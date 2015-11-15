Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :phrases
  resources :cup, :only => [:show, :update]
  resource :dashboard, :only => [:show]
end
