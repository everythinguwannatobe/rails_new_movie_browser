Rails.application.routes.draw do
  root to: 'static#home'
  get 'static/home'

  resources :movies, only: [:index, :show]
end
