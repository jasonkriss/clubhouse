require "rails_helper"

module Clubhouse
  describe MembershipPolicy do
    subject { described_class.new(user, resource) }

    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:organization) { create(:clubhouse_organization) }

    context "for an admin" do
      context "with a collection" do
        before { create(:clubhouse_membership, member: user, organization: organization, admin: true) }

        let(:resource) { organization.memberships }

        it { should authorize(:index) }
      end

      context "and their own membership" do
        let(:resource) { create(:clubhouse_membership, member: user, organization: organization, admin: true) }

        it { should authorize(:create) }
        it { should authorize(:show) }
        it { should_not authorize(:update) }
        it { should_not authorize(:destroy) }
      end

      context "and someone else's membership" do
        before { create(:clubhouse_membership, member: user, organization: organization, admin: true) }

        let(:resource) { create(:clubhouse_membership, member: other_user, organization: organization) }

        it { should authorize(:create) }
        it { should authorize(:show) }
        it { should authorize(:update) }
        it { should authorize(:destroy) }
      end
    end

    context "for a member" do
      let(:resource) { create(:clubhouse_membership, member: user, organization: organization) }

      context "with a collection" do
        before { create(:clubhouse_membership, member: user, organization: organization) }

        let(:resource) { organization.memberships }

        it { should authorize(:index) }
      end

      it { should authorize(:create) }
      it { should authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end

    context "for a non-member" do
      let(:resource) { create(:clubhouse_membership, member: other_user, organization: organization) }

      context "with a collection" do
        let(:resource) { organization.memberships }

        it { should_not authorize(:index) }
      end

      it { should authorize(:create) }
      it { should_not authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end
  end
end
