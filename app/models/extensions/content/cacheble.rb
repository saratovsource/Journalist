module Extensions
  module Content
    module Cacheble
      extend ActiveSupport::Concern
      included do
        cattr_accessor :relation_methods
        field :cache_marker, type: String, default: -> { changed_cache_marker}
        
        before_update :expire_cache
      end
      
      def cache_traverse(visitor)
        visitor << self unless visitor.include?(self)
        if !self.class.relation_methods.nil? && self.class.relation_methods.kind_of?(Array)
          self.class.relation_methods.each do |relation_method|
            cached_relations = [self.send(relation_method)].flatten.compact
            cached_relations.each{|cached_relation_object|
              unless visitor.include?(cached_relation_object)
                cached_relation_object.cache_traverse(visitor) if cached_relation_object.respond_to?(:cache_traverse)
              end
            }
          end
        end
      end
      
      def clean_cache
        self.save
      end
      
      def expire_cache
        self.cache_marker = self.changed_cache_marker
      end
      
      protected
      
      def clean_relation_cache
        Journalist::Caching::Cleaner.new(self, Journalist::Caching::CacheRelationsRetriver).clean
      end
      
      
      def changed_cache_marker
        [self.class.name, self.id, Time.now].map(&:to_s).map(&:permalink).join('-')
      end

      module ClassMethods
        
        def cachable(*args)
          self.relation_methods = args
        end
      end
    end
  end
end