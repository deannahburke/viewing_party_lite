class MoviesController < ApplicationController
  def index
    @user = current_user
    if params[:commit]
      @movies = MovieFacade.create_by_keyword(params[:q])
    else
      @movies = MovieFacade.create_top_rated
    end
  end

  def show
    @user = current_user
    @movie = MovieFacade.create_movie_details(params[:movie_id])
    @cast = MovieFacade.create_cast(params[:movie_id])
    @reviews = MovieFacade.create_reviews(params[:movie_id])
  end
end
