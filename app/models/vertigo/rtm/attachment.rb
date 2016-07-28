module Vertigo
  module Rtm
    class Attachment < ApplicationRecord
      belongs_to :message

      mount_uploader :attachment, AttachmentUploader
    end
  end
end
