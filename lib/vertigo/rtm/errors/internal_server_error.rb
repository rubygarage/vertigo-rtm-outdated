module Vertigo
  module Rtm
    module Errors
      class InternalServerError < Vertigo::Rtm::Error
        def status
          'internal_server_error'
        end

        def code
          '500'
        end

        def title
          I18n.t('errors.internal_server_error', scope: 'vertigo.rtm')
        end
      end
    end
  end
end
