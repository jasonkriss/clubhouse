require "active_model_serializers"
require "email_validator"
require "servitore"
require "punditry"

require "clubhouse/concerns"
require "clubhouse/configuration"
require "clubhouse/engine"

module Clubhouse
  TOKEN_LENGTH = 32

  class << self
    def is_id?(value)
      !!(ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Uuid::ACCEPTABLE_UUID =~ value)
    end

    def normalize_email(email)
      email.to_s.downcase.gsub(/\s+/, "")
    end

    def generate_token(length = TOKEN_LENGTH)
      SecureRandom.urlsafe_base64(length)
    end

    def invitation_url(invitation)
      config.invitation_url.call(invitation)
    end
  end
end
