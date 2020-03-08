class UsersController < ApplicationController

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
    @users = @user.followings
    render 'follow'
  end

  def followers
    @user  = User.find(params[:user_id])
    @users = @user.followers
    render 'follower'
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :email, :profile_image, :encrypted_password)
  end

end
