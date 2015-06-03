module Clubhouse
  module Concerns
    module Serializers
      module OrganizationSerializer
        extend ActiveSupport::Concern

        included do
          attributes :id,
                     :type,
                     :name,
                     :email,
                     :created_at,
                     :updated_at
        end
      end
    end
  end
end
