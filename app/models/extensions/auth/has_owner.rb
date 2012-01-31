module Extensions
  module Auth
    module HasOwner
      extend ActiveSupport::Concern
      
      included do
        #-= Associations =-
        belongs_to :owner, :class_name => "Account"
        
        # -= Validations =-
        validates_presence_of :owner
        
        # -= Scope =-
        scope :owned, ->(account) { where(:owner_id => account.id)}
      end
      
    end
  end
end