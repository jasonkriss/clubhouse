require "clubhouse/concerns/policies/ownable"

module Clubhouse
  module Concerns
    module Policies
      module InvitationPolicy
        extend ActiveSupport::Concern

        include Ownable

        def index?
          admin?
        end

        def create?
          admin?
        end

        def show?
          admin?
        end

        def update?
          admin?
        end

        def destroy?
          admin?
        end

        def permitted_attributes
          if resource.new_record?
            [:email, :admin]
          else
            [:admin]
          end
        end
      end
    end
  end
end
