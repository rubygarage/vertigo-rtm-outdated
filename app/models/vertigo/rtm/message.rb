module Vertigo
  module Rtm
    class Message < ApplicationRecord
      belongs_to :creator, class_name: Vertigo::Rtm.user_class
      belongs_to :conversation, counter_cache: true
      has_many   :attachments, dependent: :destroy

      validates :text, presence: true
    end
  end
end