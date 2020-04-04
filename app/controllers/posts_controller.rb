class PostsController < ApplicationController

  before_action :set_categorys, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all.page(params[:page]).per(10)
    @categorys = Category.all

    if params[:id]
      @category = Category.find(params[:id])
      @posts = @category.posts.order(created_at: :desc).page(params[:page]).per(10)
    end

  end

  def show
    @post = Post.find(params[:id])
    @category = @post.category
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(10)
    @like = Like.new

    if user_signed_in?
      new_history = @post.browsing_histories.new
      new_history.user_id = current_user.id
    end

    if user_signed_in? && current_user.browsing_histories.exists?(post_id: params[:id])
      old_history = current_user.browsing_histories.find_by(post_id: params[:id])
      old_history.destroy
    end

    if user_signed_in?
      new_history.save
      histories_stock_limit = 10
      histories = current_user.browsing_histories.all
    end

    if user_signed_in? && histories.count > histories_stock_limit
      histories[0].destroy
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).per(10)
    if @posts.count == 0
      flash.now[:notice] = "ヒットする投稿がありませんでした。"
    end
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to root_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。下記を修正し、再度お願いいたします。"
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    if user_signed_in? && @post.user == current_user
      @user = @post.user
      @category = @post.category
    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集しました。"
      redirect_to post_path
    else
      flash.now[:alert] = "編集に失敗しました。下記を修正し、再度お願いいたします。"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:success] = "レビューを削除しました。"
      redirect_to posts_path
    else
      flash.now[:alert] = "削除に失敗しました。再度お願いします。"
      redirect_to post_path(post.id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :post_image, :post_title, :body, :aroma, :acidity, :rich, :bitterness, :rate)
  end

  def set_categorys
    @categorys = Category.all
  end

end
