RSpec.shared_context 'Error object' do
  RSpec.shared_examples 'has error properties' do |properties|
    it "has status #{properties[:status]}" do
      expect(error.status).to eq(properties[:status])
    end

    it "has code #{properties[:code]}" do
      expect(error.code).to eq(properties[:code])
    end

    it "has title #{properties[:title]}" do
      expect(error.title).to eq(properties[:title])
    end

    it 'has details' do
      expect(error.details).to eq(details)
    end
  end
end
