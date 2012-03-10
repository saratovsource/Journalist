module Journalist
  class RenderFactory < Array
    attr_accessor :input, :output, :formatters
    
    def initialize(content = nil, args = {})
      @input = content
      @formatters = args.delete(:formatters) || []
    end
    
    # Render method/
    def render(&block)
      @output = @input
      render_chained
      yield(self) if block_given?
      @output
    end
    
    # Aply formatter to content
    def apply_formatter(formatter = nil)
      if formatter && formatter.respond_to?(:process)
        @output = formatter.process(@output)
      end
    end
    
    protected
    
    # For each formatter aply it
    def render_chained
      each{|formatter| self.apply_formatter(formatter)}
    end
    
  end
end