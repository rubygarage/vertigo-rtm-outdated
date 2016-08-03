module Vertigo
  module Rtm
    class ErrorsSerializer
      def initialize(*errors)
        @errors = errors
      end

      def as_json
        { errors: errors.map { |err| error_hash(err) } }
      end

      def error_hash(error)
        base_error_hash(error).tap do |error_hash|
          if error.source_parameter.present?
            error_hash[:source] = { parameter: error.source_parameter }
          end
        end
      end

      private

      def base_error_hash(error)
        {
          status: error.status,
          code: error.code,
          title: error.title,
          detail: error.details
        }
      end

      attr_reader :errors
    end
  end
end
