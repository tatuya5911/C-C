class HomesController < ApplicationController

  def top
    if user_signed_in?
      @user = current_user
    end
    @posts = Post.all
    @categorys = Category.all
    @fresh_posts = Post.all.order(created_at: :desc).limit(10)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(30).pluck(:post_id))
  end

  def rank
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(30).pluck(:post_id))
    @posts = Post.all
  end

  def latest
    @posts = Post.all.order(created_at: :desc).limit(30).page(params[:page]).per(10)
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(30)
  end

  def policy
  end

  def privacy
  end

  def thanks
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
