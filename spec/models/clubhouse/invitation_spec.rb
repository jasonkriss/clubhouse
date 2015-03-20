require "rails_helper"

module Clubhouse
  describe Invitation do
    it { should validate_presence_of(:organization) }
    it { should validate_presence_of(:email) }
    it { should_not allow_value("invalid@email").for(:email) }
    it "validates uniqueness of email/organization" do
      create(:clubhouse_invitation, :with_associations)
      should validate_uniqueness_of(:email).scoped_to(:organization_id)
    end

    it "normalizes emails before validating" do
      invitation = create(:clubhouse_invitation, :with_associations, email: "eM ai l@eXample.com")
      expect(invitation.email).to eq("email@example.com")
    end
  end
end
