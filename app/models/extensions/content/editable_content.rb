module Extensions
  module Content
    module EditableContent
      extend ActiveSupport::Concern

      included do

        field :content
      end

      def to_html(fname = :content, args = nil)
        RedCloth.new(self.send(*[fname, args].compact)).to_html
      end

      def summary(delimiter = "cut")
        cat_array(delimiter).first || ""
      end

      def cat_link_text(delimiter = "cut")
        cat_ar = cat_array(delimiter)
        if cat_ar.size > 2
          cat_ar[1]
        else
          ""
        end
      end

      protected

      def cat_array(delimiter = "cut")
        @cat_array ||= self.content.scan(/(.*)?<!--#{delimiter}+:?(.*)?-->(.*)?/im).flatten.compact
      end
    end
  end
end
