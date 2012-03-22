module Journalist
  module Caching
    # Retrive cache relations from source item
    class CacheRelationsRetriver < Array
      attr_reader :source_element, :finished
      
      def initialize(source)
        @source_element = source
      end
      
      def retrive_cache_relations!
        @source_element.cache_traverse(self)
        self.count
      end
      
      protected
      
      def retrive_circle
        @source_element
      end
      
    end
  end
end