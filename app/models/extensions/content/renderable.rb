module Extensions
  module Content
    module Renderable
      extend ActiveSupport::Concern

      included do
        has_and_belongs_to_many :labels

        scope :latests, lambda{|n| published.desc(:published_at).limit(n)}
      end

      # Render method
      # Example AnyObject.render :page => options_hash
      def render(*args)
        case args.first
        when Symbol
          render_without_parameters(args.first)
        when Hash
          render_with_parameters(args.first)
        end
      end

      # may be overrideble
      def alternative_parent
        nil
      end

      def dynamic_labels
        labels + statistic_labels
      end

      protected

      def statistic_labels
        ret = []
        # commentable
        comment_label = Label.comment_label
        ret = ret + comment_label if (self.comments.web.count > 10 && comment_label.present?)
        # likes
        likes_label = Label.like_label
        ret = ret + likes_label if (self.rate_count > 20 && likes_label.present?)

        ret.compact
      end

      def render_without_parameters(type)
        case type
        when :page
          render_page
        else
          render_block
        end
      end

      def render_with_parameters
        if args.key?(:page)
          render_page
        else
          render_block
        end
      end

      def render_page
        Journalist::RenderEngine::Page.new(self).process
      end

      def render_block
        Journalist::RenderEngine::Block.new(self).process
      end

    end
  end
end
