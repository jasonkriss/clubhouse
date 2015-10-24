module Clubhouse
  module Concerns
    module Models
      module AttributeValidatable
        extend ActiveSupport::Concern

        module ClassMethods
          def validate_attributes!(attributes)
            record = new(attributes)

            record.validate

            ignorable = record.errors.keys - attributes.keys
            ignorable.each { |attribute| record.errors.delete(attribute) }

            raise ActiveRecord::RecordInvalid.new(record) unless record.errors.empty?

            true
          end
        end
      end
    end
  end
end
