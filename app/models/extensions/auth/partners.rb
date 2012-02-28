module Extensions
  module Auth
    module Partners
      extend ActiveSupport::Concern
      included do
        field :partners, type: Array
        field :partner
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end