module Vertigo
  module Rtm
    class ApplicationJob < ::ActiveJob::Base
      private

      def render_resource(resource, options = {})
        render_options = {
          json: resource,
          adapter: ActiveModelSerializers::Adapter::JsonApi,
          key_transform: :camel_lower
        }.merge(options)

        Vertigo::Rtm::ApplicationController.renderer.render(render_options)
      end
    end
  end
end
