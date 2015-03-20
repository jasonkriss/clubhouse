module Clubhouse
  class InvitationPolicy < Punditry::Policy
    include Concerns::Policies::InvitationPolicy
  end
end
