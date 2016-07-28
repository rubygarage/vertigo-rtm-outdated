FactoryGirl.define do
  factory :vertigo_rtm_attachment, class: 'Vertigo::Rtm::Attachment' do
    attachment {
      Rack::Test::UploadedFile.new(
        File.join('spec', 'support', 'fixtures', 'attachment.png'),
        'image/png'
      )
    }

    association :message, factory: :vertigo_rtm_message
  end
end
