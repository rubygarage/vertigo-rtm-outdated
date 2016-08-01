module Vertigo
  module Rtm
    class Preference < ApplicationRecord
      belongs_to :preferenceable, polymorphic: true
    end
  end
end
