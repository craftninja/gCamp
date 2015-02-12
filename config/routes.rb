Rails.application.routes.draw do

  root 'welcome#index'
  get '/about' => 'welcome#about', as: :about
  get '/terms' => 'welcome#terms', as: :terms
  get '/faq'   => 'welcome#faq' , as: :faq
  resources :tasks
  resources :users, only: [:index, :new, :create, :edit, :update]

end
