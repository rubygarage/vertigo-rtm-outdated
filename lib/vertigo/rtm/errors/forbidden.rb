module Vertigo
  module Rtm
    module Errors
      class Forbidden < Vertigo::Rtm::Error
        def status
          'forbidden'
        end

        def code
          '403'
        end

        def title
          I18n.t('errors.forbidden', scope: 'vertigo.rtm')
        end
      end
    end
  end
end
