module Clubhouse
  module Member
    extend ActiveSupport::Concern

    included do
      has_many :memberships, class_name: "Clubhouse::Membership", foreign_key: :member_id
      has_many :organizations, through: :memberships, class_name: "Clubhouse::Organization"
    end
  end
end
