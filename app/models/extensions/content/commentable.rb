module Extensions
  module Content
    module Commentable
      
      extend ActiveSupport::Concern
      
      included do
        has_many :comments, as: :commentable
      end

    end
  end
end