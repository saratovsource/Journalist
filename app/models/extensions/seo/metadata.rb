module Extensions
  module Seo
    module Metadata
      extend ActiveSupport::Concern
      
      included do
        field :seo_title, :type => String
        field :meta_keywords, :type => String
        field :meta_description, :type => String
        field :in_robots, :type => Boolean
      end
      
    end
  end
end