require "rails_helper"

describe "Organizations" do
  let!(:user) { create(:user) }
  let!(:session) { create(:pollett_session, user: user) }
  let!(:existing) { create(:clubhouse_organization) }
  let!(:membership) { create(:clubhouse_membership, member: user, organization: existing, admin: true) }

  describe "GET /organizations" do
    let!(:other_user) { create(:user) }
    let!(:other_organization) { create(:clubhouse_organization) }
    let!(:other_membership) { create(:clubhouse_membership, member: other_user, organization: other_organization) }

    it_requires_authentication(:get, "/organizations")

    it "responds with the authenticated user's organizations" do
      a_get("/organizations", session)
      organizations = json[:organizations]
      first = organizations.first

      expect_status(200)
      expect(organizations.count).to eq(1)
      expect(first[:id]).to eq(existing.id)
      expect_keys(first, :name, :email, :created_at, :updated_at)
    end
  end

  describe "HEAD /organizations/:name" do
    it_requires_authentication(:head, "/organizations/name")

    context "when name is taken" do
      it "responds with ok" do
        a_head("/organizations/#{existing.name}", session)

        expect_status(200)
      end
    end

    context "when name is available" do
      it "responds with not found" do
        expect do
          a_head("/organizations/available", session)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET /organizations/:id" do
    it_requires_authentication(:get, "/organizations/1")

    it "responds with the specified organization" do
      a_get("/organizations/#{existing.id}", session)
      organization = json[:organization]

      expect_status(200)
      expect(organization[:id]).to eq(existing.id)
      expect_keys(organization, :name, :email, :created_at, :updated_at)
    end
  end

  describe "GET /organizations/:name" do
    it_requires_authentication(:get, "/organizations/name")

    it "responds with the specified organization" do
      a_get("/organizations/#{existing.name}", session)
      organization = json[:organization]

      expect_status(200)
      expect(organization[:id]).to eq(existing.id)
      expect_keys(organization, :name, :email, :created_at, :updated_at)
    end
  end

  describe "POST /organizations" do
    let(:params) { { name: "name", email: "email@example.com" } }

    it_requires_authentication(:post, "/organizations")

    context "with valid params" do
      it "responds with the new organization" do
        a_post("/organizations", session, params)
        organization = json[:organization]

        expect_status(201)
        expect(organization[:name]).to eq("name")
        expect(organization[:email]).to eq("email@example.com")
        expect_keys(organization, :id, :created_at, :updated_at)
      end
    end

    context "with invalid params" do
      before { params[:email] = nil }

      it "raises an invalid record error" do
        expect do
          a_post("/organizations", session, params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "PUT /organizations/:id" do
    let(:params) { { name: "new-name", email: "newemail@example.com" } }

    it_requires_authentication(:put, "/organizations/1")

    context "with valid params" do
      it "responds with the updated organization" do
        a_put("/organizations/#{existing.id}", session, params)
        organization = json[:organization]

        expect_status(200)
        expect(organization[:id]).to eq(existing.id)
        expect(organization[:name]).to eq("new-name")
        expect(organization[:email]).to eq("newemail@example.com")
        expect_keys(organization, :created_at, :updated_at)
      end
    end

    context "with invalid params" do
      before { params[:email] = nil }

      it "raises an invalid record error" do
        expect do
          a_put("/organizations/#{existing.id}", session, params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "PUT /organizations/:name" do
    let(:params) { { name: "new-name", email: "newemail@example.com" } }

    it_requires_authentication(:put, "/organizations/name")

    context "with valid params" do
      it "responds with the updated organization" do
        a_put("/organizations/#{existing.name}", session, params)
        organization = json[:organization]

        expect_status(200)
        expect(organization[:id]).to eq(existing.id)
        expect(organization[:name]).to eq("new-name")
        expect(organization[:email]).to eq("newemail@example.com")
        expect_keys(organization, :created_at, :updated_at)
      end
    end

    context "with invalid params" do
      before { params[:email] = nil }

      it "raises an invalid record error" do
        expect do
          a_put("/organizations/#{existing.name}", session, params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "DELETE /organizations/:id" do
    it_requires_authentication(:delete, "/organizations/1")

    it "responds with nothing" do
      a_delete("/organizations/#{existing.id}", session)

      expect_status(204)
      expect(response.body).to be_empty
    end
  end

  describe "DELETE /organizations/:name" do
    it_requires_authentication(:delete, "/organizations/name")

    it "responds with nothing" do
      a_delete("/organizations/#{existing.name}", session)

      expect_status(204)
      expect(response.body).to be_empty
    end
  end
end
