require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::Unauthorized do
      subject(:error) { Errors::Unauthorized.new }
      let(:details) { I18n.t('errors.unauthorized_details', scope: 'vertigo.rtm') }

      include_context 'Error object'
      it_behaves_like 'has error properties',
                      status: 'unauthorized',
                      code: '401',
                      title: I18n.t('errors.unauthorized', scope: 'vertigo.rtm')
    end
  end
end
