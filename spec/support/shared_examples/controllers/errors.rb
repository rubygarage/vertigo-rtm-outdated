RSpec.shared_context 'controller error responses' do
  RSpec.shared_examples 'API error' do |status|
    it "responds with :#{status} http status" do
      expect(response).to have_http_status(status)
    end

    it "renders #{status} error json" do
      expect(json_response[:errors].first[:title]).to eq(t("errors.#{status}", scope: 'vertigo.rtm'))
    end
  end
end
