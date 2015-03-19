Rails.application.routes.draw do

  root 'welcome#index'
  get '/about' => 'welcome#about', as: :about
  get '/terms' => 'welcome#terms', as: :terms
  get '/faq'   => 'welcome#faq' , as: :faq
  get 'signup' => 'signup#new', as: :signup
  post '/signup' => 'signup#create'
  get 'signout' => 'auth#destroy', as: :signout
  get '/signin' => 'auth#new', as: :signin
  post 'signin' => 'auth#create'
  resources :users
  resources :projects do
    resources :tasks do
      resources :comments, only: [:create]
    end
    resources :memberships, only: [:index, :create, :update, :destroy]
  end
  resources :tracker_projects, only: [:show]

end
