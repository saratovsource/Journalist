module Extensions
  module Content
    module Commentable

      extend ActiveSupport::Concern

      included do
        has_many :comments, as: :commentable

      end

      def write_comment(message, user)
        @ret_comment = self.comments.build(:owner => user, :message => message, :site => self.site)
        @ret_comment.parent = self if self.kind_of?(Comment)
        @ret_comment.save
        @ret_comment
      end

    end
  end
end
