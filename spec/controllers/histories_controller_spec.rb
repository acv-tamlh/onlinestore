require 'rails_helper'

RSpec.describe HistoriesController, type: :controller do

  describe "GET #index" do
    it "without login" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
    it "signed in" do

    end
  end

  describe "GET #show" do
    let!(:order) { create(:order) }
    it "without login" do
      get :show, params: { id: order.id}
      expect(response).to redirect_to new_user_session_path
    end
  end

end
