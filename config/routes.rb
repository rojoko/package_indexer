Rails.application.routes.draw do
  resources :packages, only: [:index]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
