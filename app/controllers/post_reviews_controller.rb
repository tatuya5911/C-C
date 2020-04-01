class PostReviewsController < ApplicationController

  def new
    if user_signed_in?
      @post = Post.find(params[:post_id])
      @post_review = PostReview.new
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @post_review = current_user.post_reviews.new(post_review_params)
    @post_review.post_id = @post.id
    if @post_review.save
      flash[:success] = "コメントを投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "コメントに失敗しました。下記を修正し、再度お願いいたします。"
      render :new
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @post_review = current_user.post_reviews.find_by(post_id: post.id)
    @post_review.destroy!
  end

  private

  def post_review_params
    params.require(:post_review).permit(:user_id, :post_id, :title, :comment)
  end

end
