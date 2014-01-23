class MoviesController < ApplicationController

  @@movie_db = [
          {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)
      def index
          respond_to do |format|
          format.html
          format.json { render :json => @@movie_db }
          format.xml { render :xml => @@movie_db.to_xml }
        end
      end

      def search
        search_str = params[:movie]
        response = Typhoeus.get('http://www.omdbapi.com/', :params => {:s => search_str})
        @result = JSON.parse(response.body)["Search"].sort_by {|movie| movie["Year"]} 
        render :result
      end

      def result_show
        picture = params[:imdb]
        response = Typhoeus.get('http://www.omdbapi.com/', :params => {:i => picture})
        @result = JSON.parse(response.body)
        render :result_show
      end

      def add
        # movie = params.require(:movie).permit(:title, :year, :imdb)
        picture = params[:imdb]
        response = Typhoeus.get('http://www.omdbapi.com/', :params => {:i => picture})
        result = JSON.parse(response.body)
        movie = {"title" => result['Title'], "year" => result['Year'], 'imdbID' => result['imdbID'], "Type" => result['Type'] }
        @@movie_db << movie
        binding.pry
        redirect_to action: :show_all
      end

      def show_all
        @movies = @@movie_db
        render :show_all
      end

      # route: # GET    /movies/:id(.:format)
      def show
        @movie = @@movie_db.find do |m|
          m["imdbID"] == params[:id]
        end
        if @movie.nil?
          flash.now[:message] = "Movie not found" if @movie.nil?
          @movie = {}
        end
      end

      # route: GET    /movies/new(.:format)
      

      # route: GET    /movies/:id/edit(.:format)
      def edit
        get_movie
      end

      #route: # POST   /movies(.:format)
      def create
        new_movie
      end

      # route: PATCH  /movies/:id(.:format)
      def update
        get_movie
        updated_info = params.require(:movie).permit(:title, :year) 
        @movie.update(updated_info)
        redirect_to action: :index
        #implement
      end

      # route: DELETE /movies/:id(.:format)
      def destroy
        movie = @@movie_db.find do |m|
          m['imdbID'] == params[:id]
        end
        @@movie_db.delete(movie)
        redirect_to action: :show_all
        # delete movie from movie_db
        # redirect_to :index
        #implement
      end

private
  # this part is for within the controller where this will not be used anywhere else
  #but here in this class controller.

  def new_movie
    # create new movie object from 
        movie = params.require(:movie).permit(:title, :year)
        movie["imdbID"] = rand(10000..100000000).to_s
        # add object to movie db
        @@movie_db << movie
        # show movie page
        # render :index
        redirect_to action: :index
      end

  def get_movie
    @movie = @@movie_db.find do |m|
          m["imdbID"] == params[:id]
        end

        if @movie.nil?
          flash.now[:message] = "Movie not found" 
          @movie = {}
        end
        @movie
  end

end
