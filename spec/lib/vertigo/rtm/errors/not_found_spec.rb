require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::NotFound do
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::NotFound.new(details: details) }

      include_context :error_object
      it_behaves_like :has_error_properties,
                      status: 'not_found',
                      code: '404',
                      title: I18n.t('errors.not_found', scope: 'vertigo.rtm')
    end
  end
end
