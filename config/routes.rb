Movies::Application.routes.draw do
# resources creates the basic paths for you
# resources :movies
	
  root 'movies#index'
  get 'movies'  => 'movies#index', as: :movies
  get 'movies/poster/:imdb' => 'movies#result_show', as: :show_result
  post 'movies/poster/:imdb' => 'movies#add', as: :add
  post 'movies/results' => 'movies#search', as: :results
  post 'movies' => 'movies#create'
  get 'movies/new' => 'movies#new', as: :new_movie
  get 'movies/:id/edit' => 'movies#edit', as: :edit_movie
  get '/movies/show_all' => 'movies#show_all', as: :movie_show_all
  get 'movies/:id' => 'movies#show', as: :movie
  patch 'movies/:id' => 'movies#update'
  delete 'movies/:id' => 'movies#destroy'



 

#      root GET    /                          movies#index
#     movies GET    /movies(.:format)          movies#index
#            POST   /movies(.:format)          movies#create
#  new_movie GET    /movies/new(.:format)      movies#new
# edit_movie GET    /movies/:id/edit(.:format) movies#edit
#      movie GET    /movies/:id(.:format)      movies#show
#            PATCH  /movies/:id(.:format)      movies#update
#            PUT    /movies/:id(.:format)      movies#update
#            DELETE /movies/:id(.:format)      movies#destroy

  # resources :movies


end
