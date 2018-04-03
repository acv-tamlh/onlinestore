require 'rails_helper'

RSpec.describe Productgroup, type: :model do
  describe 'vaildate' do
    it { should validate_presence_of(:title) }
  end
  describe 'Association' do
    it { should have_many(:products)}
  end
end
