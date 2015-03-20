module Clubhouse
  module Concerns
    module Serializers
      module MembershipSerializer
        extend ActiveSupport::Concern

        included do
          attributes :id,
                     :admin,
                     :created_at,
                     :updated_at

          has_one :organization
          has_one :member, serializer: Clubhouse::MemberSerializer
        end
      end
    end
  end
end
