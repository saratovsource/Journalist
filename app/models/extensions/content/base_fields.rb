module Extensions
  module Content
    module BaseFields
      extend ActiveSupport::Concern
      
      included do
        include Extensions::Seo::Metadata
        # -= Fields =-
        field :title
        field :slug
        field :description
        field :fullpath
        
        # -= Associations =-
        has_one :router, :as => :routerable, :dependent => :destroy
        
        # -= Callbacks =-
        before_validation         :normalize_slug
        before_save { |p| p.fullpath = p.fullpath(true) if p }
        after_create :send_me_to_route
        after_save :update_route
        
        # -= Validations =-
        validates_presence_of     :title, :slug
        validates_exclusion_of    :slug, :in => Journalist.config.reserved_slugs#, :if => Proc.new { |p| p.depth == 0 }
      end
      
      module InstanceMethods
        
        protected
        
        def normalize_slug
          self.slug = self.title.clone if self.slug.blank? && self.title.present?
          self.slug.permalink! if self.slug.present?
        end
        
        def fullpath(force = false)
          raise Exception, "Not Implemented..."
        end
        
        def parent_path
          raise Exception, "Not Implemented..."
        end
        
        def send_me_to_route
          return if self.fullpath.nil?
          Router.register_instance(self)
        end
        
        def update_route
          return if self.fullpath.nil?
          if self.router.nil?
            send_me_to_route
          else
            self.router.update_attribute(:url, self.fullpath)
          end
        end
        
      end
    end
  end
end