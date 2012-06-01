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
      @days = self.options[:days]
      render
    end

    protected

    def build_list
    end

  end
end
