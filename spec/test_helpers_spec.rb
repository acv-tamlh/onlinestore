require 'spec_helper'

RSpec.describe 'KaminariRspec::TestHelpers::'  do

  describe 'discover_mock_framework' do
    context 'when the mock framework does not support framework_name' do
      before do
        dumb_framework = Object.new
        allow(RSpec.configuration).to receive(:mock_framework) { dumb_framework }
      end
      it 'should return :nothing' do
        expect(discover_mock_framework).to eq :nothing

      end
    end

    context 'when the mock framework does support framework_name' do
      before do
        mock_framework = RSpec.configuration.mock_framework
        allow(mock_framework).to receive(:framework_name) { :my_framework }
      end
      it 'should return the framework name' do
        expect(discover_mock_framework).to eq :my_framework
      end
    end
    context 'when the mock framework is rspec' do
      it 'should return rspec' do
        expect(discover_mock_framework).to eq :rspec
      end
      it 'should correctly mock the pagination' do
        resource = [Object.new, Object.new]
        stubbed_resource = stub_pagination(resource, total_count: 45, current_page: 3, per_page: 10)
        expect(stubbed_resource.total_count).to eq(45)
        expect(stubbed_resource.current_page).to eq(3)
      end
    end
  end
end
