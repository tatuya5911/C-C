class HomesController < ApplicationController

  def top
    @user = current_user
    @posts = Post.all
    @categorys = Category.all
    @fresh_posts = Post.all.order(created_at: :desc).limit(10)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    @histories = @user.browsing_histories.all.limit(10)
  end

  def rank
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @posts = Post.all
  end

  def index
    @posts = Post.all.order(created_at: :desc).limit(30)
  end

end
