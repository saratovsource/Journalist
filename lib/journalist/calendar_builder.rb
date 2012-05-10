module Journalist
  class CalendarBuilder < ::Array
    attr_accessor :options
    attr_accessor :date_range, :site

    def initialize(*args)
      self.options = args.extract_options!
      self.options[:width] ||= 3
      self.date_range = ((self.options[:day] - self.options[:width].days)..(self.options[:day] + self.options[:width].days))
      self.site = self.options[:site] || Site.first
      build_list
    end

    def feed
      self.site.time_lines.feed.where(:published_at => self.day)
    end

    protected

    def build_list
      self.concat self.date_range.collect{|dd| build_day(dd)}
    end

    def build_day(date)
      ret = Journalist::CalendarDay.new(date.year, date.mon, date.day)
      ret.active = (date == self.options[:day])
      ret
    end

    def day
      self.options[:day]
    end

  end
end
