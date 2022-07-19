class UsersController < ApplicationController

  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:error] = user.errors.full_messages.first
      redirect_to "/register"
    end
  end

  def show
    @user = current_user
    @invited = ViewingParty.invited(@user)
  end

  def discover
    @user = User.find(params[:id])
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
      flash[:success] = "Welcome, #{user.name}!"
    else
      flash[:error] = "Sorry, your credentials are bad"
      render :login_form
    end
  end

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
