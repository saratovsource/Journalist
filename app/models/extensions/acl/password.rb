module Extensions
  module Acl
    module Password
      extend ActiveSupport::Concern
      
      included do
        field :acl_password
        
        access_with_password :acl_password
      end
      
      module ClassMethods
        def access_with_password(*attr_names)
          acl_validates_with Journalist::Acl::PasswordValidator, _merge_attributes(attr_names)
        end
      end
      
    end
  end
end