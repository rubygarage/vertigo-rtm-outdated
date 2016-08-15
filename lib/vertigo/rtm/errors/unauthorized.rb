module Vertigo
  module Rtm
    module Errors
      class Unauthorized < Vertigo::Rtm::Error
        def status
          'unauthorized'
        end

        def code
          '401'
        end

        def title
          I18n.t('errors.unauthorized', scope: 'vertigo.rtm')
        end

        def details
          I18n.t('errors.unauthorized_details', scope: 'vertigo.rtm')
        end
      end
    end
  end
end
