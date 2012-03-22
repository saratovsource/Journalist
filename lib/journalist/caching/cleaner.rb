module Journalist
  module Caching
    class CacheCleanerError < RuntimeError
    end
    
    class SourceCacheError < CacheCleanerError
    end
    
    class CacheRetriverError < CacheCleanerError
    end
    
    # This class get changed element, visit his relations (if marked)
    # And expiring they cache
    class Cleaner
      attr_reader :source, :retriver
      attr_accessor :targets
      
      def initialize(source = nil, retriver = nil)
        @source = source
        # Exceptions
        raise SourceCacheError if @source.nil?
        # Get elements
        @retriver = retriver.new(@source)
        @retriver.retrive_cache_relations!
        self.targets = @retriver
      end
      
      def clean
        self.targets.each(&:clean_cache)
      end
      
      protected
      
      def raise_exception_if_any
        raise CacheRetriverError if (@retriver.nil? || !@retriver.is_a?(Class))
      end
      
    end
  end
end