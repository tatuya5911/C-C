class CategorysController < ApplicationController

  def index
    @category  = Category.new
    @categorys = Category.all
  end

  def create
    category = Category.new(category_params)
    if category.save!
      redirect_to categorys_path, notice:"新たなカテゴリーを作成しました"
    else
      @categorys = Category.all
      render :index, notice:"カテゴリー作成に失敗しました"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categorys_path, notice:"カテゴリー名を変更しました"
    else
      @category = Category.find(params[:id])
      render :edit, notice:"カテゴリー名変更に失敗しました."
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
