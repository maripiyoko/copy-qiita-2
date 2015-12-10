class MarkdownController < ApplicationController
  def preview
    @text = params[:text]
    respond_to do |format|
      format.js
    end
  end
end
