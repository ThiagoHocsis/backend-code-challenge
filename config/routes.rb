Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :points, only:[:create]
      get 'cost', to: "points#cost", as: :cost
    end
  end
end
