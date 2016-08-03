require 'rails_helper'

module Vertigo
  module Rtm
    describe Errors::UnprocessableEntity do
      let(:attribute) { Faker::Lorem.word }
      let(:details) { Faker::Lorem.sentence }
      subject(:error) { Errors::UnprocessableEntity.new(source_parameter: attribute, details: details) }

      include_context 'Error object'
      it_behaves_like 'has error properties',
                      status: 'unprocessable_entity',
                      code: '422',
                      title: I18n.t('errors.unprocessable_entity', scope: 'vertigo.rtm')

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
