Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "searches#index"

  resources :searches
  resources :callers
end
