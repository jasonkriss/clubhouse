Clubhouse::Engine.routes.draw do
  scope shallow: true, format: false do
    resources :organizations, except: [:new, :edit], id: /[^\/\?]+/ do
      get :check, on: :member

      resources :invitations, except: [:new, :edit]

      resources :memberships, except: [:new, :edit]
    end
  end
end
