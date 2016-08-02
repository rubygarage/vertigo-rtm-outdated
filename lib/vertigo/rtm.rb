require 'vertigo/rtm/engine'
require 'carrierwave'
require 'apipie-rails'

module Vertigo
  module Rtm
    mattr_accessor :user_class
    def self.user_class
      raise 'Please use a string instead of a class' if @@user_class.is_a?(Class)

      if @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end

    mattr_accessor :user_name_column
    self.user_name_column = :name

    mattr_accessor :current_user_method

    mattr_accessor :layout
    self.layout = 'vertigo/rtm/application'

    def self.setup
      yield self
    end
  end
end
