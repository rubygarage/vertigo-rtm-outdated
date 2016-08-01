require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::NotFound do
      let(:message) { Faker::Lorem.sentence }
      let(:error) { Errors::NotFound.new(details: message) }

      it 'has status not_found' do
        expect(error.status).to eq('not_found')
      end

      it 'has details' do
        expect(error.details).to eq(message)
      end

      it 'has code 404' do
        expect(error.code).to eq('404')
      end

      it 'has title' do
        expect(error.title).to eq(
          I18n.t('errors.not_found', scope: 'vertigo.rtm')
        )
      end
    end
  end
end
