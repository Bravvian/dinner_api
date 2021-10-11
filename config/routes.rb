Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:show, :index]
    end
  end
end
