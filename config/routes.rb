Clubhouse::Engine.routes.draw do
  scope shallow: true, format: false do
    resources :organizations, except: [:new, :edit] do
      match ":id", action: :check, on: :collection, via: :head

      resources :invitations, except: [:new, :edit]

      resources :memberships, except: [:new, :edit]
    end
  end
end
