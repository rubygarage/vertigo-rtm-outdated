module Vertigo
  module Rtm
    class UsersSearchQuery
      MIN_QUERY_LENGTH = 2
      MAX_RESULTS      = 20

      def initialize(relation, params)
        @relation = relation
        @params = params
      end

      def call
        @relation = params.key?('q') ? users_by_prefix : users_by_ids

        @relation
      end

      private

      attr_reader :relation, :params

      def users_by_prefix
        query = params['q'].to_s.strip

        if query.length >= MIN_QUERY_LENGTH
          @relation.where("#{Vertigo::Rtm.user_name_column} LIKE :query", query: "%#{query}")
                   .limit(MAX_RESULTS)
        else
          @relation.none
        end
      end

      def users_by_ids
        if params['user_ids'].present?
          @relation.rewhere(id: params['user_ids'])
        else
          @relation.none
        end
      end
    end
  end
end
