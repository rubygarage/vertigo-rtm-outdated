module Vertigo
  module Rtm
    module Exceptions
      class InternalServerErrorSerializer < BaseSerializer
        private

        def attributes
          { status: :internal_server_error, code: 500, title: 'Something went wrong.' }
        end
      end
    end
  end
end
