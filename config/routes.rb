Rails.application.routes.draw do

 resources :conversations do
    resources :messages
  end
  devise_for :users
  #resource :shops
  #root 'shops#index'
  get "/shops", to: "shops#index", as: "root"
  post "/shops", to: "shops#create"
  get "/shops/new", to: "shops#new", as: "new_shops"
  get "/shops/:id", to: "shops#show", as: "shop"
  put "/shops/:id", to: "shops#update"
  patch "/shops/:id", to: "shops#update"
  delete "/shops/:id", to: "shops#destroy"
  get "/shops/:id/edit", to: "shops#edit", as: "edit_shops"

  # get "/conversations", to: "conversations#index", as: "conversations"
  # post "/conversations", to: "conversations#create"
  # get "/messages", to: "messages#index", as: "messages"
  # post "/messages", to: "messages#create", as: "coversations_messages"

end
