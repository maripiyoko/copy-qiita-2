require 'rails_helper'

RSpec.describe DraftsController, type: :controller do

  let(:login_user) { create(:user) }

  describe "GET #index" do
    before { sign_in login_user }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should respond drafts" do
      create(:item, user: login_user)
      get :index
      expect(assigns(:drafts).count).to eq 1
    end
  end

  describe "GET #new" do
    before { sign_in login_user }

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should respond draft" do
      get :new
      respond_to(assigns(:draft))
    end
  end

  describe "GET ajax #show" do
    let!(:draft_item) { create(:item, user: login_user) }
    before { sign_in login_user }

    it "should response ajax access" do
      xhr :get, :show, id: draft_item
      expect(response).to have_http_status(:success)
      expect(assigns(:draft)).to be_valid
      expect(response.content_type).to eq('text/javascript')
    end
  end

  describe "POST #create" do
    before { sign_in login_user }

    it "should create new draft" do
      expect {
        post :create, item: attributes_for(:item, user: login_user)
      }.to change(Item, :count).by(1)
    end

    context "invalid draft" do
      it "should not change Draft count" do
        expect {
           post :create, item: attributes_for(:item, title: '')
        }.not_to change(Item, :count)
      end

      it "should respond validation error messages" do
        post :create, item: attributes_for(:item, title: '')
        expect(response.body).to have_content "error message"
      end

    end

  end
end
