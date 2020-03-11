class BrowsingHistoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @histories = user.browsing_histories.page(params[:page]).per(10)

    if current_user != user
      render root_path
    end
    
  end

end
