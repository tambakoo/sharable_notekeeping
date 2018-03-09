Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  resources :notes
  get 'tags/:tag', to: 'notes#index', as: "tag"
  get '/shared', to: 'notes#shared'
  resources :notes do
    resources :accesses
  end

  resources :accesses do 
    resources :accesses 
  end

end
