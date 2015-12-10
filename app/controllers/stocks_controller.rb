class StocksController < ApplicationController
  before_action :set_user

  def index
    @stocks = @user.stock_items
    respond_to do |format|
      format.js
    end
  end

  private

    def set_user
      @user = User.find_by_param(params[:user_id])
    end
end
