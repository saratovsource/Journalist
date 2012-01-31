module Extensions
  module Article
    module Stated
      extend ActiveSupport::Concern
      
      included do
        
        state_machine :initial => :drafted do
          
          event :prepublish do
            transition [:drafted, :rewrited] => :prepublished
          end
          
          event :publish do
            transition [:prepublished] => :published
          end
          
          event :rewrite do
            transition [:published] => :rewrited
          end
          
          event :trash do
            transition all - [:published] => :trashed
          end
          
          event :rescue do
            transition [:trashed] => :drafted
          end
        end
        
        # -=Scopes=-
        scope :must_publish, with_states([:prepublished, :published])

      end
      
      module ClassMethods
        
      end
      
      module InstanceMethods
        
      end
    end
  end
end