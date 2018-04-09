require 'rails_helper'

RSpec.describe HistoriesController, type: :controller do

  let(:user) { create(:user) }
  describe "GET #index" do
    it "without login" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
    it "signed in" do
      sign_in(user)
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    let(:orders) { create_list(:order, 10, user_id: user.id) }
    let!(:order_items) { create_list(:order_item, 20, order_id: orders.first.id) }
    it "without login" do
      get :show, params: { id: orders.first.id}
      expect(response).to redirect_to new_user_session_path
    end
    it "signed in" do
      sign_in(user)
      get :show, params: { id: orders.first.id}
      expect(response).to render_template :show
      expect(assigns(:history).size).to eq Order.paginates_per 5
    end
  end

end
