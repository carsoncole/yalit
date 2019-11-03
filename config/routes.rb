Rails.application.routes.draw do
  root "home#index"

  resources :projects do
    get 'schema' => 'projects#schema', as: 'schema'
    resources :invitations
    post 'toggle_is_published' => 'projects#toggle_is_published', as: 'toggle_is_published'
  end

  resources :sections, :sub_sections, :request_methods
  resources :user_projects
  

  resources :chapters do
    resources :sections do
      resources :sub_sections
      resources :request_methods
    end
  end
end
