Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :create, :edit, :show, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get 'about', to: 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
