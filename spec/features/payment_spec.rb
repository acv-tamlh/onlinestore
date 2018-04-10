require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'Relate To Payment', type: :feature, js: true do
  let!(:product) { create(:product) }
  let!(:user) { create(:user) }
  describe 'Pay' do
    def add_order_item_to_cart
      visit root_path
      click_on('Add to Cart')
      click_on('1 Item in cart ($199.00)')
    end
    it 'without login' do
      add_order_item_to_cart
      expect(page).to have_content('Register to checkout')
    end
    it 'signed in' do
      add_order_item_to_cart
      login_as(user)
      click_on('1 Item in cart ($199.00)')
      expect(page).to have_content('Checkout Infomation')
      expect(page).to have_button('Checkout')
      first(:css, '.btn.btn-primary').click
      # #error in paypal
      # if user.full_name.nil?
      #   expect(page).to have_content('Update infomation')
      # else
      #   expect(page).to have_content('Payment Method')
      # end

    end
  end
end
