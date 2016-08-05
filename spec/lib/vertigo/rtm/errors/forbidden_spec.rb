require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::Forbidden do
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::Forbidden.new(details: details) }

      include_context :error_object
      it_behaves_like :has_error_properties,
                      status: 'forbidden',
                      code: '403',
                      title: I18n.t('errors.forbidden', scope: 'vertigo.rtm')
    end
  end
end
