require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "render tempate index" do
      get :index
      expect(response).to render_template :index
    end
    let!(:products) { create_list(:product, 10) }
    it "get all products DESC" do
      get :index
      products.last.update(created_at: Time.now)
      products.first.update(created_at: 10.days.ago)
      expect(assigns(:products).first).to eq products.last
      expect(assigns(:products).last).to eq products.first
    end
    # let(:products) { create_list(:product, 20 ) }
    it 'get paginate' do
      get :index
      expect(assigns(:products).size).to eq 10
    end
  end

  describe "GET #show" do
    let!(:productshow){ create(:product) }
    it "returns http success" do
      get :show, params: {id: productshow.id}
      expect(response).to have_http_status(:success)
    end
    it "render template show" do
      get :show, params: {id: productshow.id}
      expect(response).to render_template :show
    end
  end




end
