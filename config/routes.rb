Rails.application.routes.draw do
  get 'characters/index'
  resources :characters
  root 'characters#index'
end
