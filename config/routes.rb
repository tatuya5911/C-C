Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'ranking' => 'homes#rank', as: "rank"
  get 'posts/category/:id' => 'posts#index', as: "posts_category"
  resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update] do
    get :following, :followers
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :show, :search, :new, :create, :edit, :update, :destroy] do
    resource :post_reviews, only: [:new, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

end
