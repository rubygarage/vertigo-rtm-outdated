require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe UsersSearchQuery do
      let!(:user) { create(:user) }
      let!(:users) { create_list(:user, 2) }

      context '#call' do
        context 'when passing `user_ids` parameter' do
          context 'when it is empty' do
            [{}, { 'user_ids' => nil }, { 'user_ids' => [] }].each do |params|
              context "and looks #{params}" do
                it 'returns empty relation' do
                  service = described_class.new(Vertigo::Rtm.user_class.all, params)
                  expect(service.call).to be_none
                end
              end
            end
          end

          context 'when is not empty' do
            let(:params) { { 'user_ids' => [user.id] } }

            it 'returns users relation' do
              service = described_class.new(Vertigo::Rtm.user_class.all, params)
              expect(service.call).to match_array([user])
            end

            it 'returns users relation with skipped user' do
              service = described_class.new(Vertigo::Rtm.user_class.where.not(id: user.id), params)
              expect(service.call).to match_array([user])
            end
          end
        end

        context 'when passing `q` parameter' do
          context 'when it is empty' do
            [{}, { 'q' => nil }, { 'q' => '' }, { 'q' => '  ' }, { 'q' => 'HI' }].each do |params|
              context "and looks #{params}" do
                it 'returns empty relation' do
                  service = described_class.new(Vertigo::Rtm.user_class.all, params)
                  expect(service.call).to be_none
                end
              end
            end
          end

          context 'when is not empty' do
            let(:params) { { 'q' => user.name } }

            it 'returns users relation' do
              service = described_class.new(Vertigo::Rtm.user_class.all, params)
              expect(service.call).to match_array([user])
            end

            it 'has query limit' do
              service = described_class.new(Vertigo::Rtm.user_class.all, params)
              expect(service.call.values).to include(limit: 20)
            end
          end
        end
      end
    end
  end
end
