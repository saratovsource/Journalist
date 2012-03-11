module Journalist
  module RenderEngine
    class Block < AbstractEngine
      
      protected
      
      def template_path
        File.join(super, "block")
      end
    end
  end
end