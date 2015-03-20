module Clubhouse
  module Concerns
    module Models
      module Emailable
        extend ActiveSupport::Concern

        included do
          before_validation :normalize_email

          validates :email, presence: true,
                            email: { strict_mode: true }
        end

        private
        def normalize_email
          self.email = Clubhouse.normalize_email(email)
        end
      end
    end
  end
end
