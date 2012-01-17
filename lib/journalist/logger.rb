module Journalist
  module Logger
    
    def self.method_missing(meth, message, &block)
      if Journalist.config.enable_logs == true
        Rails.logger.send(meth, "[-=Journalist=-] #{message}")
      end
    end
    
  end
end