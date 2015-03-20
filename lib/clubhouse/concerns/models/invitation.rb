require "clubhouse/concerns/models/emailable"

module Clubhouse
  module Concerns
    module Models
      module Invitation
        extend ActiveSupport::Concern

        include Concerns::Models::Emailable

        included do
          belongs_to :organization

          before_create :set_token

          validates :organization, presence: true
          validates :email, uniqueness: { scope: :organization_id }
        end

        private
        def set_token
          self.token = Clubhouse.generate_token
        end
      end
    end
  end
end
