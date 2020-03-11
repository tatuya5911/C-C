class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all.page(params[:page]).per(30)
  end

  def show
    @user = User.find(params[:id])
  end

  def like
    user = User.find(params[:user_id])
    @likes = user.likes.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def following
    @user  = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(30)
    render 'follow'
  end

  def followers
    @user  = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(30)
    render 'follower'
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :email, :profile_image, :encrypted_password)
  end

end
