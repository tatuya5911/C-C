class PostCommentsController < ApplicationController

  def new
    if user_signed_in?
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash[:success] = "コメントを投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "コメントに失敗しました。下記を修正し、再度お願いいたします。"
      render :new
    end
  end

  def destroy
    @post_comment = current_user.post_comments.find_by(id: params[:post_comment_id], post_id: params[:post_id])
    @post_comment.destroy!
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:user_id, :post_id, :title, :comment)
  end

end
