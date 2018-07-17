# frozen_string_literal: true

Rails.application.routes.draw do
  match '*all' => 'application#cors_preflight_check', via: :options

  resources :timelines
  resources :events

  resources :people do
    resources :identities
  end

  resources :groups do
    resources :members
  end

  resources :roles do
    resources :capabilities
  end

  resources :clients do
    member do
      get 'launch'
    end
  end
  resources :identity_providers do
    member do
      get 'launch'
    end
  end

  get 'sessions' => 'sessions#callback',	as: :callback
  post 'sessions' => 'sessions#create',	as: :login
  delete 'sessions' => 'sessions#destroy',	as: :logout
  get 'status' => 'welcome#status', as: :status
  get 'stream' => 'events#stream', as: :stream

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#landing'
end
