module Journalist
  class TimelineCell < ::MenuCell

    def widget(args = {})
      self.options = args
      render
    end

    def description(args = {})
      self.options = args
      render
    end

    def dayline(args = {})
      self.options = args
      @days = Journalist::CalendarBuilder.new(calendar_options)
      render
    end

    protected

    def build_list
    end

    def calendar_options
      {
        :day => params[:date].present? ? params[:date].strftime("%Y-%m-%d").to_date : Date.today,
        :count => 10
      }.merge(self.options)
    end

  end
end
