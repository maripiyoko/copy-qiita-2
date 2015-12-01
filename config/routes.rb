Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :drafts

  resources :users, only: [ :show ], path: '', controller: :profile do
    resources :items, only: [ :index ] do
      resource :stock, only: [ :create, :update, :destroy ]
      resource :comment, only: [ :create, :update, :destroy ]
    end
    resources :stocks, only: [ :index ]
    resources :comments, only: [ :index ]
  end
end
