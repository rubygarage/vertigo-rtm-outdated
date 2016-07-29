module Vertigo
  module Rtm
    module Exceptions
      class AccessDeniedSerializer < BaseSerializer
        private

        def attributes
          { status: :forbidden, code: 403, title: 'Access forbidden.' }
        end
      end
    end
  end
end
