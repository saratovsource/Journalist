module Journalist
  module Presenters
    class Presenter
      attr_accessor :model, :cells
      attr_reader :options

      # Default presenter for rendering in main jayout
      #  @args: model instance and options
      #
      #  example:
      #  Presenter.new JournalRubric.first, :any_option_key => "options_value"
      def initialize(*args)
        self.model = args.first
        @options = args.extract_options!
        self.cells = {}
        build_cells
      end

      def render(*args)
        model.try(:render, args)
      end

      def self.build(*args)
        instance = args.first
        presenter_class = retrive_presenter_class(instance)
        presenter_class.new(instance, args.extract_options!) if presenter_class.present?
      end

      protected

      def build_cells
        # Add realisation to childs
      end

      def self.retrive_presenter_class(instance)
        begin
          "Journalist::Presenters::#{instance.class.name.demodulize}Presenter".constantize
        rescue NameError
          nil
        end
      end

      def add(section, options = {})
        self.cells[section] = options
      end
    end
  end
end
