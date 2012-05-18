module Extensions
  module Content
    module Commentable

      extend ActiveSupport::Concern

      included do
        has_many :comments, as: :commentable
      end

      def write_comment(message, user)
        comments.create(:owner => user, :message => message)
      end

    end
  end
end
