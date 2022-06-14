class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    # PART 3 ____________________________________________________________
    
    # If coming from a non-home page, take from session

    
    if !params.key?(:home)
      @ratings_to_show_hash = session.key?(:ratings) ? session[:ratings] : Hash.new
      @sort_by =  session.key?(:sort_by) ? session[:sort_by] : nil
    # Else, take from params
    else
      @ratings_to_show_hash = params.key?(:ratings) ? params[:ratings] : Hash.new
      @sort_by = params[:sort_by]
    end


    # ___________________________________________________________________


    # PART 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    # Movie Retrieval
    @all_ratings = Movie.all_ratings

    # retrieve ratings to show
    @movies = Movie.with_ratings(@ratings_to_show_hash.keys)

    # Part 3: Save to session
    session[:ratings] = @ratings_to_show_hash



    # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    # PART 2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

 

    # Column Sorting
    # If params has the sort_by key
    if @sort_by != nil && !@sort_by.empty?
      # Class change for headers
      # class: 'hilite bg-warning' 
      @title_class = (@sort_by == "title") ? "hilite bg-warning" : ""
      @release_date_class = (@sort_by == "release_date") ? "hilite bg-warning" : ""
      # Order @movies to the correct order
      @movies = @movies.order(@sort_by.to_sym)

      # Part 3: Save to session
      session[:sort_by] = @sort_by

    end

    # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
