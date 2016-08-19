require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ViewContext do
      let(:user) { create(:user) }

      subject(:view_context) { described_class.new(user) }

      context '#vertigo_rtm_current_user' do
        it 'returns user instance' do
          expect(view_context.vertigo_rtm_current_user).to eq(user)
        end
      end

      context '#default_url_options' do
        it 'returns Rails.application.routes.default_url_options' do
          expect(view_context.default_url_options).to eq(Rails.application.routes.default_url_options)
        end
      end
    end
  end
end
