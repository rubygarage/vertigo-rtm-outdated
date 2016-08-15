module Vertigo
  module Rtm
    class ApplicationPresenter
      def initialize(object)
        @object = object
      end

      def attach_controller(controller)
        @controller = controller
        self
      end

      private

      attr_reader :object

      def controller
        @controller ||= Vertigo::Rtm::ApplicationController.new
      end

      def view_context
        @view_context ||= controller.view_context
      end
    end
  end
end
