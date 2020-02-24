Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :search, :new, :create, :edit, :update, :destroy] do
    resources :post_reviews, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

end
