class ViewingPartiesController < ApplicationController
  def new
    @user = current_user
    @users = User.all
    @movie = MovieFacade.create_movie_details(params[:movie_id])
  end

  def create
    if current_user
      @user = current_user
    else
      @movie = MovieFacade.create_movie_details(params[:movie_id])
      redirect_to "/movies/#{@movie.id}"
      flash[:error] = "You must be logged in or registered to create a viewing party"
    end
  end
end
