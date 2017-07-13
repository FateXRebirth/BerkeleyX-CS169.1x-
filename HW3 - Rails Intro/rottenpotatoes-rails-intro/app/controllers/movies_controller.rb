class MoviesController < ApplicationController
  def redirectUrl(method, url)
    mark = url.index("?")
    query = url[mark..url.length-1]
    return method+query
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.getRatings
    
    # check if all checkbox checked
    if request.original_url == root_path+"?utf8=✓&commit=Refresh"
      redirect_to session[:previously]
    end
    
    if params[:method] == "title"
      @action = "title"
      if params[:ratings]
        query = []
        @all_ratings.each do |rating, value|
          if !params[:ratings].include?(rating)
            @all_ratings[rating] = false
          else
            query.push(rating)
          end
        end
        @movies = Movie.getMoviesByRatingsTitleOrder(query)
        session[:url] = request.original_url
        session[:previously] = request.original_url
      else
        if session[:url]
          redirect_to root_path+redirectUrl("title",session[:url])
        else
          @movies = Movie.getMoviesByTitleOrder
          session[:previously] = request.original_url
        end
      end
    elsif params[:method] == "date"
      @action = "date"
      if params[:ratings]
        query = []
        @all_ratings.each do |rating, value|
          if !params[:ratings].include?(rating)
            @all_ratings[rating] = false
          else
            query.push(rating)
          end
        end
        @movies = Movie.getMoviesByRatingsDateOrder(query)
        session[:url] = request.original_url
        session[:previously] = request.original_url
      else
        if session[:url]
          redirect_to root_path+redirectUrl("date",session[:url])
        else
          @movies = Movie.getMoviesByDateOrder
          session[:previously] = request.original_url
        end
      end
    elsif params[:method] == "back"
      redirect_to session[:previously]
    else
      session.clear
      if params[:ratings]
        query = []
        @all_ratings.each do |rating, value|
          if !params[:ratings].include?(rating)
            @all_ratings[rating] = false
          else
            query.push(rating)
          end
        end
        @movies = Movie.getMoviesByRatings(query)
        session[:url] = request.original_url
        session[:previously] = request.original_url
      else
        if session[:url]
          url = session[:url]
          session.clear
          redirect_to root_path+redirectUrl("",url)
        else
          @movies = Movie.all
          session[:previously] = request.original_url
        end
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
end
