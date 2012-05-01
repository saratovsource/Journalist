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
        create_time_line()
      end

      def update_timeline
        self.time_line.save
      end
    end
  end
end
