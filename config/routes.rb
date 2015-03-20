Clubhouse::Engine.routes.draw do
  resources :organizations, except: [:new, :edit], shallow: true do
    match ":id", action: :check, on: :collection, via: :head

    resources :invitations, except: [:new, :edit]

    resources :memberships, except: [:new, :edit]
  end
end
