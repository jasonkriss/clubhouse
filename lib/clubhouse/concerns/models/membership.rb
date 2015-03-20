module Clubhouse
  module Concerns
    module Models
      module Membership
        extend ActiveSupport::Concern

        included do
          belongs_to :member, class_name: Clubhouse.config.member_model
          belongs_to :organization

          validates :member, presence: true
          validates :organization, presence: true
          validates :member_id, uniqueness: { scope: :organization_id }
        end
      end
    end
  end
end
