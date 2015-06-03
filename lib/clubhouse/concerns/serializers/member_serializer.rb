module Clubhouse
  module Concerns
    module Serializers
      module MemberSerializer
        extend ActiveSupport::Concern

        included do
          attributes :id,
                     :type,
                     :email,
                     :created_at,
                     :updated_at
        end
      end
    end
  end
end
