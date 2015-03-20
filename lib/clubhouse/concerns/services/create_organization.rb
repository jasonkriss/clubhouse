module Clubhouse
  module Concerns
    module Services
      module CreateOrganization
        extend ActiveSupport::Concern

        include Servitore::Service

        included do
          param_reader :organization, :user, :params
        end

        def call
          ActiveRecord::Base.transaction do
            organization.tap do |o|
              o.assign_attributes(params)
              o.save!
              o.memberships.create!(member: user, admin: true)
            end
          end
        end
      end
    end
  end
end
