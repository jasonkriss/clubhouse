module Clubhouse
  module Concerns
    module Services
      module CreateMembership
        extend ActiveSupport::Concern

        include Servitore::Service

        included do
          param_reader :membership, :user, :params
        end

        def call
          ActiveRecord::Base.transaction do
            membership.tap do |m|
              m.member = user
              m.admin = invitation.admin
              m.organization = invitation.organization
              m.save!
              invitation.destroy
            end
          end
        end

        private
        def invitation
          @invitation ||= Invitation.find_by!(token: params[:token])
        end
      end
    end
  end
end
