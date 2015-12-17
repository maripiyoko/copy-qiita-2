require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  let!(:login_user) { create(:user) }
  let!(:item) { create(:item, { user: login_user })}

  describe "GET #index" do
    before {
      sign_in login_user
      item.publish
      item.save
    }

    it "returns http success" do
      get :index, user_id: login_user
      expect(response).to have_http_status(:success)
    end

    it "should have login user's items" do
      get :index, user_id: login_user
      expect(assigns(:items)).to include item
    end

    it "should respond to json" do
      get :index, user_id: login_user, format: :json
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json")
    end
  end

end
