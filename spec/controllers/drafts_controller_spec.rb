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
end
