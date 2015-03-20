require "rails_helper"

describe "Invitations" do
  let!(:admin) { create(:user) }
  let!(:session) { create(:pollett_session, user: admin) }
  let!(:organization) { create(:clubhouse_organization, name: "org") }
  let!(:membership) { create(:clubhouse_membership, member: admin, organization: organization, admin: true) }
  let!(:existing) { create(:clubhouse_invitation, organization: organization) }

  describe "GET /organizations/:organization_id/invitations" do
    let!(:other_user) { create(:user) }
    let!(:other_organization) { create(:clubhouse_organization) }
    let!(:other_membership) { create(:clubhouse_membership, member: other_user, organization: other_organization) }

    it_requires_authentication(:get, "/organizations/1/invitations")

    it "responds with the organization's invitations" do
      a_get("/organizations/#{organization.id}/invitations", session)
      invitations = json[:invitations]
      first = invitations.first

      expect_status(200)
      expect(invitations.count).to eq(1)
      expect(first[:id]).to eq(existing.id)
      expect(first[:organization][:id]).to eq(organization.id)
      expect_keys(first, :email, :admin, :created_at, :updated_at)
    end
  end

  describe "GET /organizations/:organization_name/invitations" do
    let!(:other_user) { create(:user) }
    let!(:other_organization) { create(:clubhouse_organization) }
    let!(:other_membership) { create(:clubhouse_membership, member: other_user, organization: other_organization) }

    it_requires_authentication(:get, "/organizations/name/invitations")

    it "responds with the organization's invitations" do
      a_get("/organizations/#{organization.name}/invitations", session)
      invitations = json[:invitations]
      first = invitations.first

      expect_status(200)
      expect(invitations.count).to eq(1)
      expect(first[:id]).to eq(existing.id)
      expect(first[:organization][:id]).to eq(organization.id)
      expect_keys(first, :email, :admin, :created_at, :updated_at)
    end
  end

  describe "POST /organizations/:organization_id/invitations" do
    let(:params) { { email: "email@example.com", admin: true } }

    it_requires_authentication(:post, "/organizations/:organization_id/invitations")

    context "when params are valid" do
      it "responds with the new invitation" do
        a_post("/organizations/#{organization.id}/invitations", session, params)
        invitation = json[:invitation]

        expect_status(201)
        expect(invitation[:email]).to eq("email@example.com")
        expect(invitation[:admin]).to eq(true)
        expect(invitation[:organization][:id]).to eq(organization.id)
        expect_keys(invitation, :id, :created_at, :updated_at)
      end

      it "sends email" do
        a_post("/organizations/#{organization.id}/invitations", session, params)

        expect(last_email).to be_present
        expect(last_email.to).to include("email@example.com")
      end
    end

    context "when params are invalid" do
      before { params[:email] = nil }

      it "raises an invalid record error" do
        expect do
          a_post("/organizations/#{organization.id}/invitations", session, params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "POST /organizations/:organization_name/invitations" do
    let(:params) { { email: "email@example.com", admin: true } }

    it_requires_authentication(:post, "/organizations/name/invitations")

    context "when params are valid" do
      it "responds with the new invitation" do
        a_post("/organizations/#{organization.name}/invitations", session, params)
        invitation = json[:invitation]

        expect_status(201)
        expect(invitation[:email]).to eq("email@example.com")
        expect(invitation[:admin]).to eq(true)
        expect(invitation[:organization][:id]).to eq(organization.id)
        expect_keys(invitation, :id, :created_at, :updated_at)
      end

      it "sends email" do
        a_post("/organizations/#{organization.name}/invitations", session, params)

        expect(last_email).to be_present
        expect(last_email.to).to include("email@example.com")
      end
    end

    context "when params are invalid" do
      before { params[:email] = nil }

      it "raises an invalid record error" do
        expect do
          a_post("/organizations/#{organization.name}/invitations", session, params)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "GET /invitations/:id" do
    it_requires_authentication(:get, "/invitations/1")

    it "responds with the specified invitation" do
      a_get("/invitations/#{existing.id}", session)
      invitation = json[:invitation]

      expect_status(200)
      expect(invitation[:id]).to eq(existing.id)
      expect(invitation[:organization][:id]).to eq(organization.id)
      expect_keys(invitation, :email, :admin, :created_at, :updated_at)
    end
  end

  describe "PUT /invitations/:id" do
    let(:params) { { admin: true } }

    it_requires_authentication(:put, "/invitations/1")

    it "responds with the updated invitation" do
      a_put("/invitations/#{existing.id}", session, params)
      invitation = json[:invitation]

      expect_status(200)
      expect(invitation[:id]).to eq(existing.id)
      expect(invitation[:admin]).to eq(true)
      expect_keys(invitation, :organization, :email, :created_at, :updated_at)
    end
  end

  describe "DELETE /invitations/:id" do
    it_requires_authentication(:delete, "/invitations/1")

    it "responds with nothing" do
      a_delete("/invitations/#{existing.id}", session)

      expect_status(204)
      expect(response.body).to be_empty
    end
  end
end
