class ItemsController < ApplicationController
  before_action :set_user
  before_action :set_item, only: [ :show ]

  def index
    @items = @user.items.published.recent.page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: @items }
      format.js
    end
  end

  private

    def set_user
      @user = User.find_by_param(params[:user_id])
    end

    def set_item
      @item = Item.find(params[:id])
    end
end
