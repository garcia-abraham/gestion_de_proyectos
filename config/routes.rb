Rails.application.routes.draw do

  #Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :admin_user do
    authenticated :admin_user do
      root 'admin/dashboard#index'
    end
  end

  #User
  devise_for :users, :skip => [:sessions, :registrations, :passwords, :confirmations, :unlocks]

  devise_scope :user do
    authenticated :user do
      root 'projects#index'
    end
    unauthenticated do
      root 'devise/sessions#new'
    end
    post 'create' , :to => 'devise/sessions#create', :as => :user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :projects, shallow: true do
    resources :tasks do
      resources :resources
    end
    resources :group_projects, only: [:index, :new, :create, :destroy]
  end

end
