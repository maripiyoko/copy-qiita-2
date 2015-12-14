class StocksController < ApplicationController
  before_action :set_user
  before_action :set_item, only: [ :create, :destroy ]

  def index
    @stocks = @user.stock_items
    respond_to do |format|
      format.js
    end
  end

  def create
    current_user.stock(@item)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user.unstock(@item)
    respond_to do |format|
      format.js
    end
  end

  private

    def set_user
      @user = User.find_by_param(params[:user_id])
    end

    def set_item
      @item = Item.published.find(params[:item_id])
    end
end
