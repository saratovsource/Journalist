module Journalist
  module Formatters
    class CollectionFormatter
      
      def initialize(*args)
      end
      
      # Process content
      def process(content)
        content + "with links"
      end
    end
  end
end