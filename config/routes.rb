Rails.application.routes.draw do

  root to: "api/v1/listings#index"

  namespace :api do
    namespace :v1 do
      resources :listings, only: [:index]
    end
  end
end
