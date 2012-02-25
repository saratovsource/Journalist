module Extensions
  module Stick
    module Stickers
      
      extend ActiveSupport::Concern
      included do
        field :stick_homepage, type: Boolean, default: false
        field :stick_parent, type: Boolean, default: false
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end