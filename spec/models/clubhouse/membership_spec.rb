require "rails_helper"

module Clubhouse
  describe Membership do
    it { should validate_presence_of(:member) }
    it { should validate_presence_of(:organization) }
    it "validates uniqueness of member/organization" do
      create(:clubhouse_membership, :with_associations)
      should validate_uniqueness_of(:member_id).scoped_to(:organization_id)
    end
  end
end
