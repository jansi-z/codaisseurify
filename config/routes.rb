Rails.application.routes.draw do

  root to: "artists#index"

  resources :artists do
    resources :songs, only: [:show, :new, :create, :destroy]
  end

  namespace :api do
    resources :artists do
      resources :songs, only: [:show, :create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
