require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::InternalServerError do
      let(:message) { Faker::Lorem.sentence }
      let(:error) { Errors::InternalServerError.new(details: message) }

      it 'has status internal_server_error' do
        expect(error.status).to eq('internal_server_error')
      end

      it 'has details' do
        expect(error.details).to eq(message)
      end

      it 'has code 500' do
        expect(error.code).to eq('500')
      end

      it 'has title' do
        expect(error.title).to eq(
          I18n.t('errors.internal_server_error', scope: 'vertigo.rtm')
        )
      end
    end
  end
end
