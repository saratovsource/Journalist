module Journalist
  class CalendarDay < ::Date
    attr_accessor :active, :site

    def is_empty?
      self.site.time_lines.feed(self).empty?
    end
  end
end
