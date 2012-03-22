module Extensions
  module Content
    module BaseFields
      extend ActiveSupport::Concern
      
      included do
        include Extensions::Seo::Metadata
        include Renderable
        include Mongoid::Taggable
        include Mongoid::MultiParameterAttributes
        include Extensions::Site::Routerable
        include Commentable
        include Cacheble
        
        tags_separator ', '
        
        # -= Fields =-
        field :title
        field :description
        #field :fullpath
        
        # -= Validations =-
        validates_presence_of   :title
      end
      
    end
  end
end