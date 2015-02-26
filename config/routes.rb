Rails.application.routes.draw do

  root 'welcome#index'
  get '/about' => 'welcome#about', as: :about
  get '/terms' => 'welcome#terms', as: :terms
  get '/faq'   => 'welcome#faq' , as: :faq
  get 'signup' => 'signup#new', as: :signup
  post '/signup' => 'signup#create'
  get 'signout' => 'auth#destroy', as: :signout
  resources :tasks
  resources :users
  resources :projects

end
