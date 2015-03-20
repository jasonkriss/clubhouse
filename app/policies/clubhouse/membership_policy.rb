module Clubhouse
  class MembershipPolicy < Punditry::Policy
    include Concerns::Policies::MembershipPolicy
  end
end
