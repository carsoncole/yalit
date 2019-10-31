Rails.application.routes.draw do
  root "projects#index"

  resources :projects, :sections, :sub_sections
  resources :chapters do
    resources :sections do
      resources :sub_sections
    end
  end
end
