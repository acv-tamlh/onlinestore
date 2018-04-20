require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'Cart', type: :feature do
  let!(:user) { create(:user) }
  def add_order_item_to_cart
    visit root_path
    click_on('Add to Cart')
  end
  it "Without login" do
    logout(user)
    visit root_path
    expect(page).to have_no_content('History')
  end
  it 'Signed in' do
    login_as(user)
    visit root_path
    add_order_item_to_cart
    click_on('History')
    expect(page).to have_content('Checkout Infomation')
  end
end
