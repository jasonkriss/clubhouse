require "rails_helper"

module Clubhouse
  describe Mailer do
    let!(:organization) { create(:clubhouse_organization, name: "org-name") }

    describe ".invitation" do
      let!(:invitation) { create(:clubhouse_invitation, email: "john@example.com", organization: organization) }
      let(:mail) { Mailer.invitation(invitation) }

      it "sends email" do
        mail.deliver_now

        expect(last_email).to be_present
      end

      it "sets fields correctly" do
        email = mail.deliver_now

        expect(email[:from].decoded).to eq("from@example.com")
        expect(email[:to].decoded).to eq("john@example.com")
        expect(email.subject).to eq("You've been invited to join org-name")
      end

      it "renders body correctly" do
        body = mail.deliver_now.body.to_s

        expect(body).to include("accept your invitation")
        expect(body).to include("/organizations/org-name/invitations/#{invitation.token}?email=john@example.com")
        expect(body).to include("ignore this email")
      end

      it "renders layout correctly" do
        body = mail.deliver_now.body.to_s

        expect(body).to include("Hi there")
        expect(body).to include("Clubhouse Team")
      end
    end
  end
end
