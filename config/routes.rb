Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :drafts
  get 'markdown/preview'
  get 'items', controller: :home, action: :items
  get 'feeds', controller: :home, action: :feeds

  resources :users, only: [ :show ], path: '', controller: :profile do
    resources :items, only: [ :index, :show ] do
      resource :stock, only: [ :create, :destroy ]
      resource :comment, only: [ :create, :update, :destroy ]
    end
    resources :stocks, only: [ :index ]
    resources :comments, only: [ :index ]
  end

end
