module Vertigo
  module Rtm
    class UserQuery < Vertigo::Rtm::ApplicationQuery
      MIN_QUERY_LENGTH = 2
      MAX_RESULTS      = 20

      private

      def ensure_filters
        params.key?('q') ? filter_by_prefix : filter_by_ids
      end

      def filter_by_prefix
        query = params['q'].to_s.strip

        if query.length >= MIN_QUERY_LENGTH
          filter do |relation|
            relation.where("LOWER(#{Vertigo::Rtm.user_name_column}) LIKE LOWER(:query)", query: "%#{query}%")
                    .limit(MAX_RESULTS)
          end
        else
          filter(&:none)
        end
      end

      def filter_by_ids
        if params['user_ids'].present?
          filter { |relation| relation.rewhere(id: params['user_ids']) }
        else
          filter(&:none)
        end
      end
    end
  end
end
