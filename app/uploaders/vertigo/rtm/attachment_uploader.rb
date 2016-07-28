module Vertigo
  module Rtm
    class AttachmentUploader < ::CarrierWave::Uploader::Base

      storage :file

      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
