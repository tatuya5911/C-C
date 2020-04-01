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
      flash[:success] = "カテゴリーを作成しました。"
      redirect_to categorys_path
    else
      flash[:alert] = "カテゴリー作成に失敗しました。下記を修正し、再度お願いいたします。"
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
      flash[:success] = "カテゴリーを編集しました。"
      redirect_to categorys_path
    else
      flash[:alert] = "編集に失敗しました。下記を修正し、再度お願いいたします。"
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      flash[:success] = "カテゴリーを削除しました。"
      redirect_to categorys_path
    else
      flash[:alert] = "削除に失敗しました。再度お願いします"
      redirect_to categorys_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

end
