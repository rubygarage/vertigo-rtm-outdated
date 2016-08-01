RSpec.shared_examples 'unauthorized error' do
  it { expect(response).to be_unauthorized }

  it 'renders unauthorized error json' do
    expect(json_response[:errors].first[:title]).to \
      eq(t('errors.unauthorized', scope: 'vertigo.rtm'))
  end
end

RSpec.shared_examples 'unprocessable entity error' do
  it { expect(response).to be_unprocessable }

  it 'renders unprocessable entity error json' do
    expect(json_response[:errors].first[:title]).to \
      eq(t('errors.unprocessable_entity', scope: 'vertigo.rtm'))
  end
end

RSpec.shared_examples 'not found error' do
  it { expect(response).to be_not_found }

  it 'renders not found error json' do
    expect(json_response[:errors].first[:title]).to \
      eq(t('errors.not_found', scope: 'vertigo.rtm'))
  end
end

RSpec.shared_examples 'forbidden error' do
  it { expect(response).to be_forbidden }

  it 'renders forbidden error json' do
    expect(json_response[:errors].first[:title]).to \
      eq(t('errors.forbidden', scope: 'vertigo.rtm'))
  end
end
