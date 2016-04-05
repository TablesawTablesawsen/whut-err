Rails.application.routes.draw do
  root to: "users#show", id: "casetabs"

  resources :users, only: [:show]
end
