Rails.application.routes.draw do
  get "products/index"
  devise_for :users
  root to: "products#index"
end
