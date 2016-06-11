Rails.application.routes.draw do
  resources :capabilities
  resources :members
  resources :groups
  resources :roles
    resources :clients do
        member do
            get 'launch'
        end
    end
    resources :providers
    # resources :contexts
    # resources :problems
    resources :users do
        resources :identities
        member do
            # resources :labs
            # resources :issues
            # resources :encounters do
            #     resources :participants
            # end
        end
    end

    get		'sessions' => 'sessions#callback',	as: :callback
    post	'sessions' => 'sessions#authenticate',	as: :login
    delete	'sessions' => 'sessions#destroy',	as: :logout
    get 'dashboard' => 'welcome#dashboard', as: :dashboard

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    namespace :smart do
        get 'launch' => 'launch#launch'
    end
    # You can have the root of your site routed with "root"
    root 'welcome#landing'

end
