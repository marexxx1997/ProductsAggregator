Rails.application.routes.draw do
  resources :products
  root 'platforms#index', as: 'platforms_index'
  resources :platforms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'candidates', to: 'candidates#index', as: :candidates
  get '/candidates/:platform_id/:platform_product_id', to: 'candidates#show'
  # resources :candidates, only: [:index]
  resources :scans

  resources :products do
    member do
      post :accept_candidate
    end
  end
  post '/platformproducts/update_platform_product_status', to: 'platform_products#update_platform_product_status'
end
