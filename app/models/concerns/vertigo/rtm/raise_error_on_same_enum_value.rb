module Vertigo
  module Rtm
    module RaiseErrorOnSameEnumValue
      extend ::ActiveSupport::Concern

      def update!(attributes)
        defined_enums.keys.each do |enum_key|
          check_enum_changed(attributes, enum_key)
        end
        raise(ActiveRecord::RecordInvalid, self) if errors.present?
        super(attributes)
      end

      private

      def check_enum_changed(attributes, enum_key)
        enum_state = public_send(enum_key)
        if attributes[enum_key.to_sym].to_s == enum_state
          error = I18n.t(:has_been_already_state, scope: 'vertigo.rtm.errors', state: enum_state)
          errors.add(enum_key, error)
        end
      end
    end
  end
end
