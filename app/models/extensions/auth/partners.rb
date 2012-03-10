module Extensions
  module Auth
    module Partners
      extend ActiveSupport::Concern
      included do
        field :partners, type: Array
        field :partner
      end

    end
  end
end