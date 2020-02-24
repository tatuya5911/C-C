Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  resources :categorys, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update]

end
