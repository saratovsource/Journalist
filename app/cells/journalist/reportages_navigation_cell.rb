module Journalist
  class ReportagesNavigationCell < ::MenuCell

    def tabs(args={})
      self.options = args
      render
    end

    def widget(args={})
      self.options = args
      @element = current_site.reportages.first
      render
    end

    protected

    def build_list
    end

  end
end
