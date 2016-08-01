module Vertigo
  module Rtm
    class Error < ::StandardError
      attr_reader :source_parameter, :details

      def initialize(options = {})
        options.each do |attribute, value|
          instance_variable_set("@#{attribute}", value)
        end
      end

      def status
        raise NotImplementedError
      end

      def code
        raise NotImplementedError
      end

      def title
        raise NotImplementedError
      end
    end
  end
end
