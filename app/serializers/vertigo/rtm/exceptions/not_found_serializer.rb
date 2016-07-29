module Vertigo
  module Rtm
    module Exceptions
      class NotFoundSerializer < BaseSerializer
        private

        def attributes
          { status: :not_found, code: 404, title: 'Record not found.' }
        end
      end
    end
  end
end
