Rails.application.routes.draw do
  mount Pollett::Engine => "/"
  mount Clubhouse::Engine => "/"
end
