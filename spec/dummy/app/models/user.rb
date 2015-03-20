class User < ActiveRecord::Base
  include Pollett::User
  include Clubhouse::Member
end
