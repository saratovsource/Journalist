module Extensions
  module Article
    module Stated
      extend ActiveSupport::Concern

      included do
        MODERATED_MODELS = %w(JournalArticle Face)

        STATE_SYMBOLS = {
          :drafted => 'a',
          :rewrited => 'i',
          :prepublished => 'P',
          :published => '.',
          :trashed => 'x'
        }

        state_machine :initial => :drafted do

          if MODERATED_MODELS.include?(self.owner_class.name)

            event :prepublish do
              transition [:drafted, :rewrited] => :prepublished, :if => lambda {|stated| stated.can_state?(:prepublish)}
            end

            event :publish do
              transition [:prepublished] => :published, :if => lambda {|stated| stated.can_state?(:publish)}
            end

            event :rewrite do
              transition [:prepublished, :published] => :rewrited
            end

          else

            event :publish do
              transition [:drafted, :rewrited] => :published, :if => lambda {|stated| stated.can_state?(:publish)}
            end

            event :rewrite do
              transition [:published] => :rewrited
            end

          end

          event :trash do
            transition all - [:trashed, :published] => :trashed
          end

          event :rescue do
            transition [:trashed] => :drafted
          end
        end

        # -=Scopes=-
        scope :must_publish, with_states([:prepublished, :published]) if MODERATED_MODELS.include?(self.class.name)
        scope :published, with_states([:published])

      end

      def state_sym
        STATE_SYMBOLS[self.state_name]
      end

      def readonly?
        if MODERATED_MODELS.include?(self.class.name)
          return (prepublished? or published?)
        else
          published?
        end
      end

      protected

      def can_state?(state_name)
        raise "Not implemented"
      end

    end
  end
end
