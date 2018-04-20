require 'rails_helper'
require 'paypal-sdk-rest'
include PayPal::SDK::REST
RSpec.describe OrdersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: create(:order).id }
      expect(response).to have_http_status(:success)
    end
    it 'render template' do
      get :show, params: { id: create(:order).id }
      expect(response).to render_template :show
    end
  end
end
