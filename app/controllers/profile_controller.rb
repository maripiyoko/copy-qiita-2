class ProfileController < ApplicationController
  def show
    @active_tab = params[:active_tab] || :recent
  end
end
