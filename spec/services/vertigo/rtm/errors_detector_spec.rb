require 'rails_helper'

module Vertigo
  module Rtm
    describe ErrorsDetector do
      let(:service) { ErrorsDetector.new(exception) }

      context 'with ActiveRecord::RecordNotFound' do
        let(:exception) { ActiveRecord::RecordNotFound.new('') }

        context '#errors' do
          it 'returns Errors::NotFound' do
            expect(service.errors.title).to eq(
              t('errors.not_found', scope: 'vertigo.rtm')
            )
          end
        end

        context '#status' do
          it 'returns :not_found' do
            expect(service.status).to eq(:not_found)
          end
        end
      end

      context 'with Pundit::NotAuthorizedError' do
        let(:exception) { Pundit::NotAuthorizedError.new('') }

        context '#errors' do
          it 'returns Errors::Forbidden' do
            expect(service.errors.title).to eq(
              t('errors.forbidden', scope: 'vertigo.rtm')
            )
          end
        end

        context '#status' do
          it 'returns :forbidden' do
            expect(service.status).to eq(:forbidden)
          end
        end
      end

      context 'with Errors::Unauthorized' do
        let(:exception) { Errors::Unauthorized.new }

        context '#errors' do
          it 'returns Errors::Unauthorized' do
            expect(service.errors.title).to eq(
              t('errors.unauthorized', scope: 'vertigo.rtm')
            )
          end
        end

        context '#status' do
          it 'returns :unauthorized' do
            expect(service.status).to eq(:unauthorized)
          end
        end
      end

      context 'with ActiveRecord::RecordInvalid' do
        let(:invalid_record) { Channel.new(name: '').tap(&:valid?) }
        let(:exception) { ActiveRecord::RecordInvalid.new(invalid_record) }

        context '#errors' do
          it 'returns array of Errors::UnprocessableEntity' do
            expect(service.errors.first.title).to eq(
              t('errors.unprocessable_entity', scope: 'vertigo.rtm')
            )
          end
        end

        context '#status' do
          it 'returns :unprocessable_entity' do
            expect(service.status).to eq(:unprocessable_entity)
          end
        end
      end

      context 'with other errors' do
        let(:exception) { StandardError.new('') }

        context '#errors' do
          it 'returns Errors::InternalServerError' do
            expect(service.errors.title).to eq(
              t('errors.internal_server_error', scope: 'vertigo.rtm')
            )
          end
        end

        context '#status' do
          it 'returns :internal_server_error' do
            expect(service.status).to eq(:internal_server_error)
          end
        end
      end
    end
  end
end
