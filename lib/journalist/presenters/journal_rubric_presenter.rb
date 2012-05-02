module Journalist
  module Presenters
    class JournalRubricPresenter < Presenter

      def sections
        [:journal]
      end

      protected

      def build_cells
        add :main_menu, :name => "journalist/rubric_navigation", :action => :show, :options => {:section => model.id}
      end
    end
  end
end
