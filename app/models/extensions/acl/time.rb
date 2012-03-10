module Extensions
  module Acl
    module Time
      extend ActiveSupport::Concern
      
      included do
        field :acl_time_start
        field :acl_time_end
        
        access_with_time :acl_time_start
      end
      
      module ClassMethods
        def access_with_time(*attr_names)
          acl_validates_with Journalist::Acl::TimeValidator, _merge_attributes(attr_names)
        end
      end

    end
  end
end