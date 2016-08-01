require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::Forbidden do
      let(:message) { Faker::Lorem.sentence }
      let(:error) { Errors::Forbidden.new(details: message) }

      it 'has status forbidden' do
        expect(error.status).to eq('forbidden')
      end

      it 'has details' do
        expect(error.details).to eq(message)
      end

      it 'has code 403' do
        expect(error.code).to eq('403')
      end

      it 'has title' do
        expect(error.title).to eq(
          I18n.t('errors.forbidden', scope: 'vertigo.rtm')
        )
      end
    end
  end
end
