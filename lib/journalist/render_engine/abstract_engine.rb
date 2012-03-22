module Journalist
  module RenderEngine
    class AbstractEngine < AbstractController::Base
      include AbstractController::Rendering
      include AbstractController::Layouts
      include AbstractController::Helpers
      include AbstractController::Translation
      include AbstractController::AssetPaths
      include ::Rails.application.routes.url_helpers
      
      self.view_paths = ActionView::PathSet.new([::Journalist::Engine.root.join("app/views"), "app/views"])
      
      OPTIONS = {
        :cache => true
      }
      
      attr_accessor :element, :options
      
      def initialize(element, options = {})
        @element = element
        @options = OPTIONS.merge(options)
      end
      
      # Enter point of rendering ))))
      def process
        if @options[:cache]
          Rails.cache.fetch(@element.cache_marker) do
            render_template_from_path
          end
        else
          render_template_from_path
        end
      end
      
      protected
      
      def render_template_from_path
        render partial: template_path, :locals => { element: @element } if @element
      end
      
      def template_path
        File.join('shared', 'templates', @element.class.name.underscore)
      end
    end
  end
end