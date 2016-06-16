Rails.application.routes.draw do

  # resources 'snomedct/concepts' => :snomedct_concepts
  resources :snomedct_concepts, path: '/snomed/concepts' do
	  resources :snomedct_descriptions, path: '/descriptions'
  end

  resources :results
    match '*all' => 'application#cors_preflight_check', via: :options

	resources :users do
        resources :identities
		resources :interests
		resources :results
        member do
            # resources :labs
            # resources :issues
            # resources :encounters do
            # end
        end
    end

    resources :groups do
        resources :members
    end

    resources :roles do
		resources :interests
		resources :capabilities
    end

    resources :clients do
        member do
            get 'launch'
        end
    end
    resources :providers
    resources :contexts do
    	resources :foci
	    resources :participants
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
