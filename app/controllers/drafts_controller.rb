class DraftsController < ApplicationController
  before_action :set_draft_item, only: [ :show, :edit, :update, :destroy ]

  def index
    @current_id ||= params[:current_id]
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
    msg = '下書きを保存しました。'
    if params[:publish]
      @draft.publish
      msg = '記事を公開しました。'
    end
    if @draft.save
      redirect_to drafts_path(current_id: @draft.id), notice: msg
    else
      @url = drafts_path
      render :new, alert: '下書きが保存できませんでした。'
    end
  end

  def update
    msg = '下書きを更新しました。'
    if params[:publish]
      @draft.publish
      msg = '記事を公開しました。'
    end
    if @draft.update(draft_item_params)
      redirect_to drafts_path(current_id: @draft.id), notice: msg
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
