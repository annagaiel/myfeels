Rails.application.routes.draw do

  devise_for :users,
    :path => '',
    :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
    :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  root "pages#home"

  resources :phrases
  resource :cup, :only => [:show, :create]
  resource :dashboard, :only => [:show]
  resources :emotions
end
