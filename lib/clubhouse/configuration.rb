module Clubhouse
  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  class Configuration
    attr_accessor :member_model,
                  :parent_mailer,
                  :from_email,
                  :invitation_url

    def initialize
      @member_model = "User"
      @parent_mailer = ::ApplicationMailer
      @invitation_url = ->(invitation) { "https://example.com/organizations/#{invitation.organization.name}/invitations/#{invitation.token}?email=#{invitation.email}" }
    end
  end
end
