module Clubhouse
  module Concerns
    module Services
      module CreateInvitation
        extend ActiveSupport::Concern

        include Servitore::Service

        included do
          param_reader :invitation, :params
        end

        def call
          invitation.tap do |i|
            i.assign_attributes(params)
            i.save!
            Mailer.invitation(i).deliver_later
          end
        end
      end
    end
  end
end
