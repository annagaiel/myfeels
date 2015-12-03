Rails.application.routes.draw do

  devise_for :users,
    :path => '',
    :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
    :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  root "pages#home"

  resources :phrases do
    resources :comments, :only => [:edit, :create, :update, :destroy]
  end

  resource :cup, :only => [:show, :create] do
    collection do
      delete 'clear_all'
    end
  end
  resource :dashboard, :only => [:show]
  resources :emotions do
    collection do
      delete 'bulk_delete'
    end
  end
end
