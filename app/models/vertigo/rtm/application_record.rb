module Vertigo
  module Rtm
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
