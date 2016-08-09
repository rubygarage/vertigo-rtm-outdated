module Vertigo
  module Rtm
    module Errors
      class NotFound < Vertigo::Rtm::Error
        def status
          'not_found'
        end

        def code
          '404'
        end

        def title
          I18n.t('errors.not_found', scope: 'vertigo.rtm')
        end
      end
    end
  end
end
