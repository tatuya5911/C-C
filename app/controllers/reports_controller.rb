class ReportsController < ApplicationController

  def index
    if user_signed_in? && current_user.admin == true
      @reports = Report.all
    else
      redirect_to root_path
    end
  end

  def thanks
  end

  def new
    @report = Report.new
    unless user_signed_in?
      redirect_to root_path
    end
    
    if params[:post_id].present?
      @post = Post.find(params[:post_id])
    else
      @post_review = PostReview.find(params[:post_review_id])
    end
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    @report.save!
    redirect_to thanks_path
  end

  def destroy
    if user_signed_in? && current_user.admin == true
      report = Report.find(params[:id])
      report.destroy!
      redirect_to reports_path
    else
      redirect_to root_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:user_id, :post_review_id, :post_id, :body)
  end

end
