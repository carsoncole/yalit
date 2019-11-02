Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    get 'schema' => 'projects#schema', as: 'schema'
    resources :invitations
  end

  resources :sections, :sub_sections
  resources :user_projects
  

  resources :chapters do
    resources :sections do
      resources :sub_sections
    end
  end
end
