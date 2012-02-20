module Extensions
  module Stick
    module Homepage
      extend ActiveSupport::Concern
      included do
        field :stick_homepage, type: Boolean, default: false
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end