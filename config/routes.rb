Rails.application.routes.draw do
  root "projects#show", {id: 1}

  resources :projects, :sections, :sub_sections
  resources :chapters do
    resources :sections do
      resources :sub_sections
    end
  end
end
