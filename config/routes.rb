Rails.application.routes.draw do

  root to: "homes#top"
  get "homes/about" => "homes#about"
  get '/search', to: 'search#search'

devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}
resources :users, only: [:show, :edit, :update] do
  resources :tackles, only: [:new, :create, :destroy]
  resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
end

resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end

resources :columns
resources :contacts, only: [:index, :show, :new, :create]


end
