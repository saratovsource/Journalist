module Journalist
  module RenderEngine
    class AbstractEngine < AbstractController::Base
      include AbstractController::Rendering
      include AbstractController::Layouts
      include AbstractController::Helpers
      include AbstractController::Translation
      include AbstractController::AssetPaths
      include ::Rails.application.routes.url_helpers

      include Journalist::Routing::SiteDispatcher

      self.view_paths = ActionView::PathSet.new([::Journalist::Engine.root.join("app/views"), "app/views"])

      attr_accessor :element, :options

      cache_method :process

      def initialize(element, options = {})
        @element = element
        @options = options
      end

      # Enter point of rendering ))))
      def process
        render_template_from_path
      end

      protected

      def as_cache_key
        {:name => @element.class.name, :id => @element.id, :updated_at => @element.updated_at}
      end

      def render_template_from_path
        render partial: template_path, :locals => { element: @element, options: @options } if @element
      end

      def template_path
        File.join('shared', 'templates', @element.class.name.underscore)
      end
    end
  end
end
