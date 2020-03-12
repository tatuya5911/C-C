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
    @post_review = PostReview.new
    @post_reviews = @post.post_reviews.page(params[:page]).per(10)
    @like = Like.new

    if user_signed_in?
      new_history = @post.browsing_histories.new
      new_history.user_id = current_user.id
    end

    if user_signed_in? && current_user.browsing_histories.exists?(post_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(post_id: "#{params[:id]}")
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
    redirect_to posts_url
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).per(10)
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
      redirect_to post_path(@post.id)
    else
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
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :post_image, :post_title, :body, :aroma, :acidity, :rich, :bitterness, :rate)
  end

  def set_categorys
    @categorys = Category.all
  end

end
