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
    get 'toggle-editor' => 'projects#toggle_editor', as: 'toggle_editor'
    get 'schema' => 'chapters#schema', as: 'schema'
    get 'details' => 'projects#details', as: 'details'
    get 'users' => 'projects#users', as: 'users'
    get 'servers' => 'projects#servers', as: 'servers'
    get 'host_name' => 'projects#host_name', as: 'host_name'
    resources :invitations
    post 'toggle_is_published' => 'projects#toggle_is_published', as: 'toggle_is_published'
  end

  resources :request_methods do 
    get 'ping' => 'request_methods#ping', as: 'ping'
    resources :parameters
  end

  resources :sections do
    resources :resource_attributes
    get 'ping' => 'sections#ping', as: 'ping'
    get 'process' => 'sections#process_resource', as: 'process_resource'
  end 

  resources :sub_sections
  resources :user_projects, :servers
  
  resources :sections do
    resources :error_codes
  end

  resources :chapters, except: [:index] do
    resources :sections do
      resources :sub_sections
      resources :request_methods
    end
    get 'testapi' => 'testapi#index', as: 'testapi'
    post 'set-api-key' => 'testapi#set_api_key_cookie', as: 'set_api_key'
  end
end
