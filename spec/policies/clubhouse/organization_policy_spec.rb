require "rails_helper"

module Clubhouse
  describe OrganizationPolicy do
    subject { described_class.new(user, resource) }

    let(:user) { create(:user) }
    let(:resource) { create(:clubhouse_organization) }

    context "for a collection" do
      let(:resource) { user.organizations }

      it { should authorize(:index) }
    end

    context "for an admin" do
      before { create(:clubhouse_membership, member: user, organization: resource, admin: true) }

      it { should authorize(:create) }
      it { should authorize(:check) }
      it { should authorize(:show) }
      it { should authorize(:update) }
      it { should authorize(:destroy) }
    end

    context "for a member" do
      before { create(:clubhouse_membership, member: user, organization: resource) }

      it { should authorize(:create) }
      it { should authorize(:check) }
      it { should authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end

    context "for a non-member" do
      it { should authorize(:create) }
      it { should authorize(:check) }
      it { should_not authorize(:show) }
      it { should_not authorize(:update) }
      it { should_not authorize(:destroy) }
    end
  end
end
