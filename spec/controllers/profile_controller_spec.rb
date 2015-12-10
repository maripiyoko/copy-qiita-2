require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  let(:login_user) { create(:user) }

  describe "GET #show" do
    before { sign_in login_user }

    it "returns http success" do
      get :show, id: login_user
      expect(response).to have_http_status(:success)
    end
  end

end
