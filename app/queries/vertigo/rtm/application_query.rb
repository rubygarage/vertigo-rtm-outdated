module Vertigo
  module Rtm
    class ApplicationQuery
      def initialize(relation, params)
        @relation = relation
        @params = params
      end

      def results
        @results ||= begin
          ensure_filters
          relation
        end
      end

      protected

      attr_reader :relation, :params

      def ensure_filters
        raise(NotImplementedError)
      end

      def filter
        @relation = yield(relation)
      end
    end
  end
end
