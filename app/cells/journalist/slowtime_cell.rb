module Journalist
  class SlowtimeCell < ::MenuCell

    def description(args = {})
      self.options = args
      render
    end

    protected

    def build_list
    end
  end
end
