class HomesController < ApplicationController

  def top
    @user = current_user
    @categorys = Category.all
    @posts = Post.all
  end

  def rank
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @posts = Post.all
  end

end
