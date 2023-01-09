Rails.application.routes.draw do
  resources :todos, except: [:new, :show]
  root "todos#index"
end
