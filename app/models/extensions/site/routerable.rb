module Extensions
  module Site
    module Routerable
      extend ActiveSupport::Concern
      included do
        field :slug
        
        # -= Associations =-
        has_one :router, :as => :routerable, :dependent => :destroy
        
        # -= Callbacks =-
        before_validation   :normalize_slug
        after_create        :register_router
        after_save          :update_route
        
        validates_presence_of   :slug
        validates_exclusion_of  :slug, :in => Journalist.config.reserved_slugs#, :if => Proc.new { |p| p.depth == 0 }
      end

      def fullpath
        return self.router.nil? ? nil : self.router.fullpath
      end
      
      def parent_path
        return self.router.nil? ? nil : self.router.parent_url
      end
      
      protected
      
      def normalize_slug
        self.slug = self.title.clone if self.slug.blank? && self.title.present?
        self.slug.permalink! if self.slug.present?
      end
      
      def register_router
        Router.register_instance(self)
      end
      
      def update_route
        if self.router.nil?
          register_router
        else
          self.router.update_attribute(:url, self.fullpath)
        end
      end
    end
  end
end