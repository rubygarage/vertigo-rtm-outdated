require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::NotFound do
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::NotFound.new(details: details) }

      include_context 'Error object'
      it_behaves_like 'has error properties',
                      status: 'not_found',
                      code: '404',
                      title: I18n.t('errors.not_found', scope: 'vertigo.rtm')
    end
  end
end
