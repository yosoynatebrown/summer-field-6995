Rails.application.routes.draw do
  get '/studios', to: 'studios#index'

  get '/movies/:id', to: 'movies#show'
  post '/movies/:id/actors', to: 'movies#update'

  get '/actors/:id', to: 'actors#show'
end
