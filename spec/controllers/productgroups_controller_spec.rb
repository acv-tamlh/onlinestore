require 'rails_helper'

RSpec.describe ProductgroupsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'render template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: create(:productgroup).id }
      expect(response).to have_http_status(:success)
    end
    it 'render template' do
      get :show, params: { id: create(:productgroup).id }
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    def create (title = 'abc', desc = 'has')
      post :create, params: { productgroup: FactoryBot.attributes_for(:productgroup, title: title, description: desc) }
    end
    it "create sucessfully" do
      expect{ create }.to change(Productgroup, :count).by(1)
      expect(response).to redirect_to productgroup_path(Productgroup.last.id)
      # expect(flash[:notice]).to eq "Create sucessfully"
    end
    it 'Create fail' do
      expect{ create('') }.to change(Productgroup, :count).by(0)
      expect(response).to render_template :new
      # expect(flash[:alert]).to eq "Create fail"
    end
  end

end
