RSpec.shared_examples :per_page do |limit = 100|
  it 'has amount of elements per page' do
    expect(described_class.per_page).to eq(limit)
  end
end
