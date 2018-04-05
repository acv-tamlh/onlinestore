require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validate' do
    it { should validate_presence_of(:asin) }
    it { should validate_presence_of(:title) }
  end
  describe 'Association' do
    it { should belong_to(:productgroup) }
    it { should have_many(:order_items) }
  end
end
