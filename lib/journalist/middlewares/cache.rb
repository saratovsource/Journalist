require 'rack/cache'

module Journalist
  module Middlewares
    class Cache
      
      def initialize(app, opts = {}, &block)
        url_format = Journalist::Dragonfly.app.configuration[:url_format]
        base_format = url_format.split('/:').first rescue '/images/dynamic'
        
        @regexp = %r{^#{base_format}/}
        @app = app
        @context = ::Rack::Cache.new(app, opts, &block)
      end
      
      def call(env)
        if env['PATH_INFO'] =~ @regexp
          @context.call(env)
        else
          @app.call(env)
        end
      end
      
    end
  end
end