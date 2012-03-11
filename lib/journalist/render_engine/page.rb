module Journalist
  module RenderEngine
    class Page < AbstractEngine
      
      protected
      
      def template_path
        File.join(super, "page")
      end
      
    end
  end
end