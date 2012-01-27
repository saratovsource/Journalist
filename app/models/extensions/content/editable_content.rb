module Extensions
  module Content
    module EditableContent
      extend ActiveSupport::Concern
      
      included do
        
        field :content
      end

    end
  end
end