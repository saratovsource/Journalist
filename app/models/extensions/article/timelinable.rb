module Extensions
  module Article
    module Timelinable
      extend ActiveSupport::Concern
      included do
        has_one :time_line, as: :timelinable

        after_create :create_timeline
        after_update :update_timeline

      end

      protected

      def create_timeline
        create_time_line(:published_at => self.publish_at)
      end

      def update_timeline
        if self.time_line.present?
          self.time_line.update_attributes(:published_at => self.publish_at)
        else
          create_timeline
        end
      end
    end
  end
end
