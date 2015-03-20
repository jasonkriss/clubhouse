module Clubhouse
  module Concerns
    module Mailers
      module Mailer
        extend ActiveSupport::Concern

        included do
          default from: Clubhouse.config.from_email if Clubhouse.config.from_email
        end

        def invitation(invitation)
          @invitation = invitation
          @organization = invitation.organization
          @url = Clubhouse.invitation_url(@invitation)

          mail(to: @invitation.email, subject: default_i18n_subject(organization: @organization.name))
        end
      end
    end
  end
end
