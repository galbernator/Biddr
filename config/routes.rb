Rails.application.routes.draw do

  root 'welcome#index'

  resources :auctions do
    resources :bids, only: [:new, :create, :destroy]
  end

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
