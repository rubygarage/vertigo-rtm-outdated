module Vertigo
  module Rtm
    module Exceptions
      class UnprocessableEntitySerializer < BaseSerializer
        private

        def error_list
          errors.map { |prop, details| error_object(prop, details) }
        end

        def error_object(prop, details)
          attributes.merge(
            detail: details,
            source: {
              parameter: prop
            }
          )
        end

        def errors
          @errors ||= exception.record.errors
        end

        def attributes
          { status: :unprocessable_entity, code: 422 }
        end
      end
    end
  end
end
