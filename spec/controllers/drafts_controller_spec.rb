require 'rails_helper'

RSpec.describe DraftsController, type: :controller do

  let(:login_user) { create(:user) }

  describe "GET #index" do
    before { sign_in login_user }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    before { sign_in login_user }

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET ajax #show" do
    let!(:draft) { create(:draft, user: login_user) }
    before { sign_in login_user }

    it "should response ajax access" do
      xhr :get, :show, id: draft
      expect(response).to have_http_status(:success)
      expect(assigns(:draft)).to be_valid
      expect(response.content_type).to eq('text/javascript')
    end
  end

  describe "POST #create" do
    before { sign_in login_user }

    it "should create new draft" do
      expect {
        post :create, draft: attributes_for(:draft, user: login_user)
      }.to change(Draft, :count).by(1)
    end

    context "invalid draft" do
      it "should not change Draft count" do
        expect {
           post :create, draft: attributes_for(:draft, title: '')
        }.not_to change(Draft, :count)
      end

      it "should respond validation error messages" do
        post :create, draft: attributes_for(:draft, title: '')
        expect(response.body).to have_content "error message"
      end

    end

  end
end
