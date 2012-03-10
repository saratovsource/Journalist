module Extensions
  module Content
    module Sortable
      extend ActiveSupport::Concern
      
      included do
        field :position, type: Integer
        default_scope asc(:position)
      end
      
      module ClassMethods
        def sort!(ids = [])
          ids.each_with_index do |id, position|
            item = find(id)
            if item
              item.position = position
              item.save
            end
          end
        end
      end
      
    end
  end
end