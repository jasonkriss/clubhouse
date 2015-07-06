require "rails_helper"

describe "Memberships" do
  let!(:admin) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:session) { create(:pollett_session, user: admin) }
  let!(:organization) { create(:clubhouse_organization, name: "org") }
  let!(:existing) { create(:clubhouse_membership, member: admin, organization: organization, admin: true) }
  let!(:other_membership) { create(:clubhouse_membership, member: other_user, organization: organization) }

  describe "GET /organizations/:organization_id/memberships" do
    it_requires_authentication(:get, "/organizations/1/memberships")

    it "responds with the organization's memberships" do
      a_get("/organizations/#{organization.id}/memberships", session)

      expect_status(200)
      expect(data.count).to eq(2)
      expect_keys(data.first[:attributes], :admin, :created_at, :updated_at)
    end
  end

  describe "GET /organizations/:organization_name/memberships" do
    it_requires_authentication(:get, "/organizations/name/memberships")

    it "responds with the organization's memberships" do
      a_get("/organizations/#{organization.name}/memberships", session)

      expect_status(200)
      expect(data.count).to eq(2)
      expect_keys(data.first[:attributes], :admin, :created_at, :updated_at)
    end
  end

  describe "POST /organizations/:organization_id/memberships" do
    let!(:new_user) { create(:user) }
    let!(:new_session) { create(:pollett_session, user: new_user) }
    let!(:invitation) { create(:clubhouse_invitation, organization: organization, admin: true) }
    let(:params) { { token: invitation.token } }

    it_requires_authentication(:post, "/organizations/1/memberships")

    context "when token is valid" do
      it "responds with the new membership" do
        a_post("/organizations/#{organization.id}/memberships", new_session, params)

        expect_status(201)
        expect(data[:attributes][:admin]).to eq(true)
        expect(data[:relationships][:member][:data][:id]).to eq(new_user.id)
        expect(data[:relationships][:organization][:data][:id]).to eq(organization.id)
        expect_keys(data[:attributes], :created_at, :updated_at)
      end
    end

    context "when token is not valid" do
      before { params[:token] = "invalid" }

      it "raises a not found error" do
        expect do
          a_post("/organizations/#{organization.id}/memberships", new_session, params)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST /organizations/:organization_name/memberships" do
    let!(:new_user) { create(:user) }
    let!(:new_session) { create(:pollett_session, user: new_user) }
    let!(:invitation) { create(:clubhouse_invitation, organization: organization, admin: true) }
    let(:params) { { token: invitation.token } }

    it_requires_authentication(:post, "/organizations/name/memberships")

    context "when token is valid" do
      it "responds with the new membership" do
        a_post("/organizations/#{organization.name}/memberships", new_session, params)

        expect_status(201)
        expect(data[:attributes][:admin]).to eq(true)
        expect(data[:relationships][:member][:data][:id]).to eq(new_user.id)
        expect(data[:relationships][:organization][:data][:id]).to eq(organization.id)
        expect_keys(data[:attributes], :created_at, :updated_at)
      end
    end

    context "when token is not invalid" do
      before { params[:token] = "invalid" }

      it "raises a not found error" do
        expect do
          a_post("/organizations/#{organization.name}/memberships", new_session, params)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET /memberships/:id" do
    it_requires_authentication(:get, "/memberships/1")

    it "responds with the specified membership" do
      a_get("/memberships/#{existing.id}", session)

      expect_status(200)
      expect(data[:id]).to eq(existing.id)
      expect_keys(data[:attributes], :admin, :created_at, :updated_at)
    end
  end

  describe "PUT /memberships/:id" do
    let(:params) { { admin: true } }

    it_requires_authentication(:put, "/memberships/1")

    it "responds with the updated membership" do
      a_put("/memberships/#{other_membership.id}", session, params)

      expect_status(200)
      expect(data[:id]).to eq(other_membership.id)
      expect(data[:attributes][:admin]).to eq(true)
      expect_keys(data[:attributes], :created_at, :updated_at)
    end
  end

  describe "DELETE /memberships/:id" do
    it_requires_authentication(:delete, "/memberships/1")

    it "responds with nothing" do
      a_delete("/memberships/#{other_membership.id}", session)

      expect_status(204)
      expect(response.body).to be_empty
    end
  end
end
