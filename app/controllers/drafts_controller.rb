class DraftsController < ApplicationController
  before_action :set_draft, only: [ :show, :edit, :update, :destroy ]

  def index
    @drafts = current_user.drafts.recent
  end

  def new
    @draft = current_user.drafts.new
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    @draft = current_user.drafts.new(draft_params)
    if @draft.save
      redirect_to drafts_path, notice: '下書きを保存しました。'
    else
      render :new, alert: '下書きが保存できませんでした。'
    end
  end

  def update
    if @draft.update(draft_params)
      redirect_to drafts_path, notice: '下書きを更新しました。'
    else
      render :edit, alert: '下書きが更新できませんでした。'
    end
  end

  def destroy
    @draft.destroy
    redirect_to drafts_path, notice: '下書きを削除しました。'
  end

  private

    def set_draft
      @draft = current_user.drafts.find(params[:id])
    end
  
    def draft_params
      params.require(:draft).permit([ :title, :content, :tag_list ])
    end
end
