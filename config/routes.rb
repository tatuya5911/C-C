Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'ranking' => 'homes#rank', as: "rank"
  get 'latest' => 'homes#latest', as: "latest"
  get 'homes/:user_id' => 'homes#index', as: "homes"
  get 'policy' => 'homes#policy', as: "policy"
  get 'privacy' => 'homes#privacy', as: "privacy"
  get 'posts/category/:id' => 'posts#index', as: "posts_category"
  get 'thanks' => 'homes#thanks', as: "thanks"
  get 'browsing_histories/:user_id' => 'browsing_histories#index', as: "browsing_histories"
  get 'search' => 'posts#search', as: "search"
  resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :like, :edit, :update] do
    get :following, :followers, :like
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :show, :search, :new, :create, :edit, :update, :destroy] do
    resources :post_reviews, only: [:new, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :reports, only: [:index, :new, :create, :destroy]

end
