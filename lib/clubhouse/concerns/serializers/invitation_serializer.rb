module Clubhouse
  module Concerns
    module Serializers
      module InvitationSerializer
        extend ActiveSupport::Concern

        included do
          attributes :id,
                     :type,
                     :email,
                     :admin,
                     :created_at,
                     :updated_at

          belongs_to :organization
        end
      end
    end
  end
end
