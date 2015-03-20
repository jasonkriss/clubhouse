module Clubhouse
  module Concerns
    module Serializers
      module InvitationSerializer
        extend ActiveSupport::Concern

        included do
          attributes :id,
                     :email,
                     :admin,
                     :created_at,
                     :updated_at

          has_one :organization
        end
      end
    end
  end
end
