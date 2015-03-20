require "clubhouse/concerns/policies/ownable"

module Clubhouse
  module Concerns
    module Policies
      module MembershipPolicy
        extend ActiveSupport::Concern

        include Ownable

        def index?
          member?
        end

        def create?
          true
        end

        def show?
          member?
        end

        def update?
          admin? && !self?
        end

        def destroy?
          admin? && !self?
        end

        def permitted_attributes
          if resource.new_record?
            [:token]
          else
            [:admin]
          end
        end

        private
        def self?
          resource.member == user
        end
      end
    end
  end
end
