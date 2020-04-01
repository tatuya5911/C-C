class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    if user_signed_in? && current_user.admin == true
      @users = User.all.page(params[:page]).per(30)
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def like
    user = User.find(params[:user_id])
    @likes = user.likes.page(params[:page]).per(30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "更新に失敗しました。下記を修正し、再度お願いいたします。"
      render :edit
    end
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
