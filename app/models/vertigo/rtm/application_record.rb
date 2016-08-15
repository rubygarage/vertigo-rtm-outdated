module Vertigo
  module Rtm
    class ApplicationRecord < ActiveRecord::Base
      include Vertigo::Rtm::RaiseErrorOnSameEnumValue

      self.abstract_class = true

      self.per_page = 100
    end
  end
end
