Rails.application.routes.draw do
  root to: 'scraped_products#index'
  resources :scraped_products
end
