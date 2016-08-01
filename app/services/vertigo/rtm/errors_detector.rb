module Vertigo
  module Rtm
    class ErrorsDetector
      attr_reader :errors

      def initialize(raw_error)
        @raw_error = raw_error
        @errors = detected_error
      end

      def status
        Array.wrap(errors).first.status.to_sym
      end

      private

      def detected_error
        case raw_error
        when ActiveRecord::RecordInvalid
          Errors::UnprocessableEntity.from_record(raw_error.record)
        when Pundit::NotAuthorizedError
          Errors::Forbidden.new(details: raw_error.message)
        when ActiveRecord::RecordNotFound
          Errors::NotFound.new(details: raw_error.message)
        when Errors::Unauthorized then Errors::Unauthorized.new
        else Errors::InternalServerError.new(details: raw_error.message)
        end
      end

      attr_reader :raw_error
    end
  end
end
