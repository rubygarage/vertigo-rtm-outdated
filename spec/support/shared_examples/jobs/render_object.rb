RSpec.shared_examples :render_object do
  it 'it serializes data' do
    default_options = {
      adapter: ActiveModelSerializers::Adapter::JsonApi,
      key_transform: :camel_lower
    }

    renderer = Vertigo::Rtm::ApplicationController.renderer
    expect(renderer).to receive(:render).with(default_options.merge(options))

    perform_enqueued_jobs { subject }
  end
end
