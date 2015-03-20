module Clubhouse
  module Concerns
    module Policies
      module OrganizationPolicy
        extend ActiveSupport::Concern

        def index?
          parent == user
        end

        def create?
          true
        end

        def check?
          true
        end

        def show?
          member?
        end

        def update?
          admin?
        end

        def destroy?
          admin?
        end

        def permitted_attributes
          [:name, :email]
        end

        private
        def admin?
          resource.admin?(user)
        end

        def member?
          resource.member?(user)
        end
      end
    end
  end
end
