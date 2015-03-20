require "rails_helper"

module Clubhouse
  describe Organization do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
    it "validates uniqueness of name" do
      create(:clubhouse_organization)
      should validate_uniqueness_of(:name)
    end

    it { should validate_presence_of(:email) }
    it { should_not allow_value("invalid@email").for(:email) }
    it { should_not allow_value("invalid_name").for(:name) }
    it { should_not allow_value("-invalid").for(:name) }
    it { should_not allow_value("1invalid").for(:name) }

    it "normalizes emails before validating" do
      org = create(:clubhouse_organization, email: "eM ai l@eXample.com")
      expect(org.email).to eq("email@example.com")
    end

    it "normalizes names before validating" do
      org = create(:clubhouse_organization, name: "n A m E")
      expect(org.name).to eq("n-a-m-e")
    end

    describe ".locate!" do
      context "when organization exists" do
        let!(:organization) { create(:clubhouse_organization, name: "name") }

        it "finds the organization by id" do
          org = Organization.locate!(organization.id)
          expect(org).to eq(organization)
        end

        it "finds the organization by name" do
          org = Organization.locate!(organization.name)
          expect(org).to eq(organization)
        end
      end

      context "when organization does not exist" do
        it "raises a not found error" do
          expect do
            Organization.locate!("name")
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
