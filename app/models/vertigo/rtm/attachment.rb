module Vertigo
  module Rtm
    class Attachment < ApplicationRecord
      belongs_to :message, inverse_of: :attachments

      mount_uploader :attachment, AttachmentUploader
    end
  end
end
