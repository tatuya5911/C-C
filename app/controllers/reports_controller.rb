class ReportsController < ApplicationController

  def index
    if user_signed_in? && current_user.admin == true
      @reports = Report.all.order(:post_id, :post_comment_id).page(params[:page]).per(30)
    else
      redirect_to root_path
    end
  end

  def new
    @report = Report.new
    unless user_signed_in?
      redirect_to root_path
    end

    if params[:post_id].present?
      @post = Post.find(params[:post_id])
    else
      @post_comment = PostComment.find(params[:post_comment_id])
    end
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to thanks_path
    else
      flash[:alert] = "通報に失敗しました。再度お願いします"
      redirect_to post_path(@report.post.id)
    end
  end

  def destroy
    report = Report.find(params[:id])
    if report.destroy
      flash[:success] = "削除しました。"
      redirect_to reports_path
    else
      flash[:alert] = "削除に失敗しました。再度お願いします"
      redirect_to reports_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:user_id, :post_comment_id, :post_id, :body)
  end

end
