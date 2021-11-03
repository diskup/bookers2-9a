Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => 'homes#about'
  root 'homes#top'
  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/search', to: 'searches#search'
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
end