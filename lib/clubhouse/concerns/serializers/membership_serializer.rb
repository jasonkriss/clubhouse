module Clubhouse
  module Concerns
    module Serializers
      module MembershipSerializer
        extend ActiveSupport::Concern

        included do
          attributes :admin,
                     :created_at,
                     :updated_at

          belongs_to :organization
          belongs_to :member, serializer: Clubhouse::MemberSerializer
        end
      end
    end
  end
end
