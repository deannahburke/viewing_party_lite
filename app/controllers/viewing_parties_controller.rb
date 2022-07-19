class ViewingPartiesController < ApplicationController

  def new
    @movie = MovieFacade.create_movie_details(params[:movie_id])
    @user = current_user
    @users = User.all
  end

  def create
  end

end
