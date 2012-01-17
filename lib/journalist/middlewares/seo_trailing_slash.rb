module Journalist
  module Middlewares
    class SeoTrailingSlash
      
      def initialize(app, opts = {})
        @app = app
      end
      
      def call(env)
        path = env['PATH_INFO']
        
        #TODO Add godmode_path to configuration
        if !path.starts_with?('/godmode/') && (match = path.match(%r{(.+)/$}))
          response = Rack::Response.new
          response.redirect(match[1], 301) # moved permanently
          response.finish
          response.to_a
        else
          @app.call(env)
        end
      end
      
    end
  end
end