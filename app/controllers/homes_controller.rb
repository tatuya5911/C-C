class HomesController < ApplicationController

  def top
    @user = current_user
    @posts = Post.all
    @categorys = Category.all
    @fresh_posts = Post.all.order(created_at: :desc).limit(10)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(30).pluck(:post_id))
  end

  def rank
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(30).pluck(:post_id))
    @posts = Post.all
  end

  def index
    @posts = Post.all.order(created_at: :desc).limit(30).page(params[:page]).per(10)
  end

end
