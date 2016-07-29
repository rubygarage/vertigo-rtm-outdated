module Vertigo
  module Rtm
    module Exceptions
      class BaseSerializer
        def initialize(exception)
          @exception = exception
        end

        def as_json
          {
            errors: error_list
          }
        end

        private

        def error_list
          [
            attributes.merge(
              detail: exception.message
            )
          ]
        end

        def attributes
          raise NotImplementedError
        end

        attr_reader :exception
      end
    end
  end
end
