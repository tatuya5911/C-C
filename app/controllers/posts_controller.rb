class PostsController < ApplicationController

  before_action :set_categorys, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all
    @categorys = Category.all

    if params[:id]
      @category = Category.find(params[:id])
      @posts = @category.posts.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @category = @post.category
    @user = @post.user
    @post_review = PostReview.new
    @post_reviews = @post.post_reviews
    @like = Like.new
    new_history = @post.browsing_histories.new
    new_history.user_id = current_user.id
    if current_user.browsing_histories.exists?(post_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(post_id: "#{params[:id]}")
      old_history.destroy
    end
    new_history.save
    histories_stock_limit = 10
    histories = current_user.browsing_histories.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end
  end

  def search
    @posts = Post.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice:"投稿しました"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    @category = @post.category
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

  def self.search(search)
    if search
      Post.where(['content LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

end
