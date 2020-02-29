class ReportsController < ApplicationController

  def index
    if current_user.admin == false
      redirect_to root_path
    end
    @reports = Report.all
  end

  def thanks
  end

  def new
    @report = Report.new
    if params[:post_id].present?
      @post = Post.find(params[:post_id])
    else
      @post_review = PostReview.find(params[:post_review_id])
    end
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    binding.pry
    @report.save!
    redirect_to thanks_path
  end

  def destroy
    if current_user.admin == false
      redirect_to root_path
    end
    report = Report.find(params[:id])
    report.destroy!
    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:user_id, :post_review_id, :post_id, :body)
  end

end
