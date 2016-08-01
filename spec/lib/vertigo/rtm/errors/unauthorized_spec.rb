require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::Unauthorized do
      let(:error) { Errors::Unauthorized.new }

      it 'has status unauthorized' do
        expect(error.status).to eq('unauthorized')
      end

      it 'has details' do
        expect(error.details).to eq(
          I18n.t('errors.unauthorized_details', scope: 'vertigo.rtm')
        )
      end

      it 'has code 401' do
        expect(error.code).to eq('401')
      end

      it 'has title' do
        expect(error.title).to eq(
          I18n.t('errors.unauthorized', scope: 'vertigo.rtm')
        )
      end
    end
  end
end
