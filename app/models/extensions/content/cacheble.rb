module Extensions
  module Content
    
    # This method implement Caching rendered elements by updated_at
    # If element updated, we must update all elements, included it
    # And theys parent too.
    module Cacheble
      
      extend ActiveSupport::Concern
      included do
        field :cache_marker
        
        #before_create :set_default_marker
        before_validation :expire_cache
      end
      
      def expire_cache
        self.set_default_marker
        relations_for_cache.each do |rel|
          rel.send(:expire_cache) if rel.respond_to?(:expire_cache)
        end
      end
      
      protected
      
      def set_default_marker
        self.cache_marker = [Time.now.nsec].join('-')
      end
      
      def relations_for_cache
        %w(parent owner).select{|i| self.respond_to?(i)}.collect{|m| self.send(m)}
      end
      
    end
  end
end