require 'rails_helper'

RSpec.describe 'Relate To Product', type: :feature do
  let(:total_count) { 40 }
  let!(:resource) { create_list(:product, total_count) }
  it 'should correctly mock the pagination' do
    stubbed_resource = stub_pagination(resource, total_count: total_count, current_page: 2, per_page: 20)
    expect(stubbed_resource.total_count).to eq(total_count)
    expect(stubbed_resource.current_page).to eq(2)
  end
end
