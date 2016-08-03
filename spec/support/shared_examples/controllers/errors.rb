RSpec.shared_context 'controller error responses' do
  RSpec.shared_examples 'API error' do |error_type|
    let(:status) { error_type == :unprocessable_entity ? :unprocessable : error_type }

    it "responds with status :#{error_type}" do
      expect(response).to send("be_#{status}")
    end

    it "renders #{error_type} error json" do
      expect(json_response[:errors].first[:title]).to eq(t("errors.#{error_type}", scope: 'vertigo.rtm'))
    end
  end
end
