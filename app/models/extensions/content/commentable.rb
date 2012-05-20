module Extensions
  module Content
    module Commentable

      extend ActiveSupport::Concern

      included do
        has_many :comments, as: :commentable

      end

      def write_comment(message, user)
        self.comments.create(:owner => user, :message => message, :site => self.site)
      end

    end
  end
end
