Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'ranking' => 'homes#rank', as: "rank"
  resources :homes, only: [:index]
  get 'posts/category/:id' => 'posts#index', as: "posts_category"
  resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :like, :edit, :update] do
    get :following, :followers, :like
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :show, :search, :new, :create, :edit, :update, :destroy] do
    resource :post_reviews, only: [:new, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :reports, only: [:index, :new, :create, :destroy]
  get 'thanks' => 'homes#thanks', as: "thanks"
  get 'browsing_histories/:user_id' => 'browsing_histories#index', as: "browsing_histories"
  get 'search' => 'posts#search', as: "search"
  get '*path' => 'homes#top'

end
