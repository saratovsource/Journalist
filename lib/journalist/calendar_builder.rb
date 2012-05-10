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

    def prev_month_day(current_date = nil)
      current_date = self.options[:day].prev_month if current_date.blank?
      first_in_month(current_date)
    end

    def next_month_day(current_date = nil)
      current_date = self.options[:day].next_month if current_date.blank?
      first_in_month(current_date)
    end

    protected

    def first_in_month(date)
      self.site.time_lines.feed.where(:published_at => date.beginning_of_month..date.end_of_month).asc(:published_at).first.try(:published_at)
    end

    def build_list
      self.concat self.date_range.collect{|dd| build_day(dd)}
    end

    def build_day(date)
      ret = Journalist::CalendarDay.new(date.year, date.mon, date.day)
      ret.active = (date == self.options[:day])
      ret.site = self.site
      ret
    end

    def day
      self.options[:day]
    end

  end
end
