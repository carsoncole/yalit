Rails.application.routes.draw do
  get 'servers/index'
  get 'servers/show'
  get 'servers/edit'
  get 'servers/update'
  get 'servers/create'
  get 'servers/destroy'
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'projects#index', as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'home#index'
  end

  resources :projects do
    get 'schema' => 'chapters#schema', as: 'schema'
    get 'basic' => 'projects#basic', as: 'basic'
    get 'api_details' => 'projects#api_details', as: 'api_details'
    get 'users' => 'projects#users', as: 'users'
    get 'host_name' => 'projects#host_name', as: 'host_name'
    resources :invitations
    post 'toggle_is_published' => 'projects#toggle_is_published', as: 'toggle_is_published'
  end

  resources :sections, :sub_sections, :request_methods
  resources :user_projects, :servers
  

  resources :chapters do
    resources :sections do
      resources :sub_sections
      resources :request_methods
    end
  end
end
