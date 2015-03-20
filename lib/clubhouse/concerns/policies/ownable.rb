module Clubhouse
  module Concerns
    module Policies
      module Ownable
        extend ActiveSupport::Concern

        private
        def admin?
          owner.admin?(user)
        end

        def member?
          owner.member?(user)
        end

        def owner
          @owner ||= if collection?
            parent
          else
            resource.organization
          end
        end
      end
    end
  end
end
