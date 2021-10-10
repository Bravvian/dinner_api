Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "application#home"

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:show, :index]
    end
  end
end
