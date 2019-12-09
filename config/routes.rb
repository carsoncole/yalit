Rails.application.routes.draw do
  get 'sign_up' => "users#new", as: 'noname'
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'projects#index', as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'home#index'
  end

  get 'not_found' => 'home#not_found', as: 'not_found'

  resources :projects do
    get 'schema' => 'chapters#schema', as: 'schema'
    get 'api_details' => 'projects#api_details', as: 'api_details'
    get 'users' => 'projects#users', as: 'users'
    get 'host_name' => 'projects#host_name', as: 'host_name'
    resources :invitations
    post 'toggle_is_published' => 'projects#toggle_is_published', as: 'toggle_is_published'
  end

  resources :request_methods do 
    get 'ping' => 'request_methods#ping', as: 'ping'
  end

  resources :sections, :sub_sections
  resources :user_projects, :servers
  
  resources :sections do
    resources :error_codes
  end

  resources :chapters, except: [:index] do
    resources :sections do
      resources :sub_sections
      resources :request_methods
    end
  end
end
