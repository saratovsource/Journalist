module Journalist
  class ReportagesNavigationCell < ::MenuCell

    def tabs(args={})
      self.options = args
      render
    end

    protected

    def build_list
    end

  end
end
