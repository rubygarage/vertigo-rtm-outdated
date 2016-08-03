require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::InternalServerError do
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::InternalServerError.new(details: details) }

      include_context :error_object
      it_behaves_like :has_error_properties,
                      status: 'internal_server_error',
                      code: '500',
                      title: I18n.t('errors.internal_server_error', scope: 'vertigo.rtm')
    end
  end
end
