module Clubhouse
  class Mailer < Clubhouse.config.parent_mailer
    include Concerns::Mailers::Mailer
  end
end
