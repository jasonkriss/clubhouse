Clubhouse.configure do |config|
  config.invitation_url = ->(invitation) { "https://example.com/organizations/#{invitation.organization.name}/invitations/#{invitation.token}?email=#{invitation.email}" }
end
