require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Association' do
    it { should have_many(:order_items) }
    it { should belong_to(:user) }
  end
  describe 'Hook' do

  end
end
