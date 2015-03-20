require "rails_helper"

module Clubhouse
  describe InvitationPolicy do
    subject { described_class.new(user, resource) }

    let(:user) { create(:user) }
    let(:organization) { create(:clubhouse_organization) }
    let(:resource) { create(:clubhouse_invitation, organization: organization) }

    context "for an admin" do
      before { create(:clubhouse_membership, member: user, organization: organization, admin: true) }

      context "with a collection" do
        let(:resource) { organization.invitations }

        it { should authorize(:index) }
      end

      it { should authorize(:create) }
      it { should authorize(:show) }
      it { should authorize(:update) }
      it { should authorize(:destroy) }
    end

    context "for a member" do
      before { create(:clubhouse_membership, member: user, organization: organization) }

      context "with a collection" do
        let(:resource) { organization.invitations }

        it { should_not authorize(:index) }
      end

      it { should_not authorize(:create) }
      it { should_not authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end

    context "for a non-member" do
      context "with a collection" do
        let(:resource) { organization.invitations }

        it { should_not authorize(:index) }
      end

      it { should_not authorize(:create) }
      it { should_not authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end
  end
end
