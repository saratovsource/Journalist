module Journalist
  class CalendarBuilder < ::Array
    attr_accessor :options
    def initialize(*args)
      self.options = args.extract_options!
      build_list
    end

    protected

    def build_list
      # TODO: Get list of days
    end
  end
end
