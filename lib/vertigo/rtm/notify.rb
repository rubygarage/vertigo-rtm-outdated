module Vertigo
  module Rtm
    module Notify
      module_function

      def for(event, resource)
        "Vertigo::Rtm::Notify::#{event.tr('.', '/').camelize}".constantize.new(resource)
      end
    end
  end
end
