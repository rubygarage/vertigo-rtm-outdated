module Vertigo
  module Rtm
    module Errors
      class UnprocessableEntity < Vertigo::Rtm::Error
        def self.from_record(record)
          record.errors.map do |attribute, message|
            new(source_parameter: attribute, details: message)
          end
        end

        def status
          'unprocessable_entity'
        end

        def code
          '422'
        end

        def title
          I18n.t('errors.unprocessable_entity', scope: 'vertigo.rtm')
        end
      end
    end
  end
end
