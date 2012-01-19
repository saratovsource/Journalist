module Extensions
  module Content
    module BaseFields
      extend ActiveSupport::Concern
      
      included do
        # -= Fields =-
        field :title
        field :slug
        field :description
        field :fullpath
        
        # -= Callbacks =-
        before_validation         :normalize_slug
        before_save { |p| p.fullpath = p.fullpath(true) }
        
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
        
      end
    end
  end
end