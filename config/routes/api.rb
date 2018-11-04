Rails.application.routes.draw do
  namespace :api do
    resources :images, only: [] do
      post :daily, on: :collection
    end

  end
end
