require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::UnprocessableEntity do
      let(:attribute) { Faker::Lorem.word }
      let(:details) { Faker::Lorem.sentence }
      let(:error) do
        Errors::UnprocessableEntity.new(source_parameter: attribute, details: details)
      end

      it 'has status unprocessable_entity' do
        expect(error.status).to eq('unprocessable_entity')
      end

      it 'has details' do
        expect(error.details).to eq(details)
      end

      it 'has code 422' do
        expect(error.code).to eq('422')
      end

      it 'has title' do
        expect(error.title).to eq(
          I18n.t('errors.unprocessable_entity', scope: 'vertigo.rtm')
        )
      end

      it 'has source_parameter' do
        expect(error.source_parameter).to eq(attribute)
      end

      context '.from_record' do
        let(:invalid_record) do
          Channel.new(name: '', creator_id: nil).tap(&:valid?)
        end
        let(:result) { Errors::UnprocessableEntity.from_record(invalid_record) }

        it 'populates Errors::UnprocessableEntity array from errors' do
          expect(result.count).to eq(invalid_record.errors.count)
        end
      end
    end
  end
end
