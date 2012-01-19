module Extensions
  module Auth
    module HasOwner
      extend ActiveSupport::Concern
      
      included do
        #-= Associations =-
        referenced_in :owner, :class_name => "Account"
        
        # -= Validations =-
        validates_presence_of :owner
      end
      
    end
  end
end