module Clubhouse
  module Concerns
    module Models
      module Organization
        extend ActiveSupport::Concern

        include Emailable
        include AttributeValidatable

        NAME_REGEX = /\A[a-z][a-z\d\-]*\z/

        included do
          has_many :invitations
          has_many :memberships
          has_many :members, through: :memberships, class_name: Clubhouse.config.member_model

          before_validation :normalize_name

          validates :name, presence: true,
                           length: { maximum: 30 },
                           format: NAME_REGEX,
                           uniqueness: true
        end

        module ClassMethods
          def locate(id_or_name)
            located(id_or_name).first
          end

          def locate!(id_or_name)
            located(id_or_name).first!
          end

          def located(id_or_name)
            field = Clubhouse.is_id?(id_or_name) ? :id : :name
            where(field => id_or_name)
          end

        end

        def member?(member)
          memberships.exists?(member: member)
        end

        def admin?(member)
          memberships.exists?(admin: true, member: member)
        end

        private
        def normalize_name
          self.name = Clubhouse.normalize_name(name)
        end
      end
    end
  end
end
