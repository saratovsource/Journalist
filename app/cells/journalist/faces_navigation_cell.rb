module Journalist
  class FacesNavigationCell < ::MenuCell

    def description(args = {})
      self.options = args
      render
    end

    def tabs(args = {})
      self.options = args
      render
    end

    def widget(args={})
      self.options = args
      render
    end

    protected

    def build_list
    end
  end
end
