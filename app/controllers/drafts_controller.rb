class DraftsController < ApplicationController
  before_action :set_draft_item, only: [ :show, :edit, :update, :destroy ]

  def index
    @drafts = current_user.items.drafts
  end

  def new
    @url = drafts_path
    @draft = current_user.items.new
  end

  def edit
    @url = draft_path(@draft)
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    @draft = current_user.items.new(draft_item_params)
    if @draft.save
      redirect_to drafts_path, notice: '下書きを保存しました。'
    else
      @url = drafts_path
      render :new, alert: '下書きが保存できませんでした。'
    end
  end

  def update
    if @draft.update(draft_item_params)
      redirect_to drafts_path, notice: '下書きを更新しました。'
    else
      @url = draft_path(@draft)
      render :edit, alert: '下書きが更新できませんでした。'
    end
  end

  def destroy
    @draft.destroy
    redirect_to drafts_path, notice: '下書きを削除しました。'
  end

  private

    def set_draft_item
      @draft = current_user.items.drafts.find(params[:id])
    end
  
    def draft_item_params
      params.require(:item).permit([ :title, :content, :tag_list ])
    end
end
