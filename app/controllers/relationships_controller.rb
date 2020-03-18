class RelationshipsController < ApplicationController

  before_action :set_user

  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
      redirect_to user
    else
      flash[:alert] = "フォローに失敗しました。再度お願いします"
      redirect_to user
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      redirect_to user
    else
      flash[:alert] = "フォロー解除に失敗しました。再度お願いします"
      redirect_to user
    end
  end

  private

  def set_user
    user = User.find(params[:follow_id])
  end

end
