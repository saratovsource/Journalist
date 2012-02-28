module Extensions
  module Article
    module Publish
      extend ActiveSupport::Concern
      included do
        field :publish_at, type: DateTime, default: -> {Time.now}
      end
    end
  end
end