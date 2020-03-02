class BrowsingHistoriesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @histories = user.browsing_histories
  end

end
