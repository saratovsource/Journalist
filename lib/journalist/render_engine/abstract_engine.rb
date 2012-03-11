module Journalist
  module RenderEngine
    class AbstractEngine < AbstractController::Base
      include AbstractController::Rendering
      include AbstractController::Layouts
      include AbstractController::Helpers
      include AbstractController::Translation
      include AbstractController::AssetPaths
      
      self.view_paths = "app/views"
      
      OPTIONS = {}
      
      attr_accessor :element, :options
      
      def initialize(element, options = {})
        @element = element
        @options = OPTIONS.merge(options)
      end
      
      # Enter point of rendering ))))
      def process
        render partial: template_path, :locals => { element: @element } if @element
      end
      
      protected
      
      def template_path
        File.join('shared', 'templates', @element.class.name.underscore)
      end
    end
  end
end