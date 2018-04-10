require 'rails_helper'

RSpec.describe 'Cart', type: :feature, js: true do
  let!(:product) { create(:product) }
  def add_order_item_to_cart
    visit root_path
    click_on('Add to Cart')
  end
  describe 'show cart' do
    it 'show order_item in cart' do
      add_order_item_to_cart
      find(:xpath, ".//h4[@class='cart-text']/a[@class='btn btn-link']").click
      expect(page).to have_content product.title
    end
  end
  describe 'Add item to cart' do
    it 'add item index page' do
      add_order_item_to_cart
      expect(page).to have_content ('1 Item in cart ($199.00)')
    end
    it 'add in product details page' do
      visit product_path(product.id)
      expect(page).to have_content(product.title)
      within find('.right-container.col-md-4.well') do
        fill_in 'order_item[quantity]', with: 123
        click_on('Add to Cart')
      end
      expect(page).to have_content('1 Item in cart ($24,477.00)')
    end
  end
  describe 'Update item in cart' do
    it 'update quantity, add order_item' do
      visit root_path
      click_on(product.title)
      expect(page).to have_content(product.title)
      within find('.right-container.col-md-4.well') do
        fill_in 'order_item[quantity]', with: 2
        click_on('Add to Cart')
      end
      expect(page).to have_content('1 Item in cart ($398.00)')
      expect(find_field('order_item[quantity]').value.to_i).to eq 2
    end
    it 'update quantity in cart' do
      visit root_path
      expect(page).to have_content(product.title)
      click_on('Add to Cart')
      expect('1 Item in cart ($199.00)')
      click_on('1 Item in cart ($199.00)')
      expect(page).to have_content product.title
      form_id = '#edit_order_item_' + OrderItem.last.id.to_s
      within find(form_id) do
        fill_in 'order_item[quantity]', with: 2
        click_on('Update Quantity')
      end
      page.driver.browser.navigate.refresh
      expect(page).to have_content('1 Item in cart ($398.00)')
      expect(find_field('order_item[quantity]').value.to_i).to eq 2
    end
  end
  describe 'Delete item in cart' do
    it "delete" do
      visit root_path
      click_on('Add to Cart')
      click_on('1 Item in cart ($199.00)')
      form_id = '#edit_order_item_' + OrderItem.last.id.to_s
      within find(form_id) do
        page.accept_confirm do
          click_link 'Delete'
        end
      end
      expect(page).not_to have_content('1 Item in cart ($398.00)')
    end
  end
end
