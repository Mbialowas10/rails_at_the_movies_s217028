Rails.application.routes.draw do
  resources :pages, except: [:show]

  get '/pages/:permalink' => "pages#permalink", as: 'permalink'
  #get 'home/index'
  # get 'production_companies/index'
  # get 'production_companies/show'
  # get 'movies/index'
  # get 'movies/show'

  root to: "home#index"
  resources :movies, only: [:index, :show]
  resources :production_companies, only: [:index, :show]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
