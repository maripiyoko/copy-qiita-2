class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @active_tab = params[:active_tab] || :all
  end

  def items
    @items = Item.published.recent.page params[:page]
    respond_to do |format|
      format.js
    end
  end

  def feeds
    # FIXME
    @items = Item.published.recent.page params[:page]
    respond_to do |format|
      format.js { render :items }
    end
  end
end
