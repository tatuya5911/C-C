class CategorysController < ApplicationController

  def index
    if user_signed_in? && current_user.admin == true
      @category  = Category.new
      @categorys = Category.all
    else
      redirect_to root_path
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categorys_path
    else
      @categorys = Category.all
      render :index
    end
  end

  def edit
    if user_signed_in? && current_user.admin == true
      @category = Category.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categorys_path
    else
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy!
    redirect_to categorys_path
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

end
