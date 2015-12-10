class ItemsController < ApplicationController
  def index
    @items = current_user.items
    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end
end
