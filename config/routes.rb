Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  get '/dashboard', to: 'users#show'
  get 'discover', to: 'users#discover'
  get '/movies', to: 'movies#index'
  get '/movies/:movie_id', to: 'movies#show'

  get '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#create'
end
