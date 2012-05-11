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
        self.content.scan(/(.*)?<!--#{delimiter}-->(.*)?/im).flatten.compact.first || ""
      end
    end
  end
end
