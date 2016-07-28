module Vertigo
  module Rtm
    class ChannelSerializer < ApplicationSerializer
      attributes :name, :status, :creator_id, :last_read_at, :created_at, :updated_at
      has_many :members

      def last_read_at
        Time.zone.now
      end
    end
  end
end
