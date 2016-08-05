module Vertigo
  module Rtm
    class ApplicationRecord < ActiveRecord::Base
      include Vertigo::Rtm::RaiseErrorOnSameEnumValue

      self.abstract_class = true
    end
  end
end
