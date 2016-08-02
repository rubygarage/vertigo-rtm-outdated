require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::Forbidden do
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::Forbidden.new(details: details) }

      include_context 'Error object'
      it_behaves_like 'has error properties',
                      status: 'forbidden',
                      code: '403',
                      title: I18n.t('errors.forbidden', scope: 'vertigo.rtm')
    end
  end
end
