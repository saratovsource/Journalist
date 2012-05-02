module Journalist
  module Presenters
    class JournalArticlePresenter < Presenter

      def sections
        [:journal]
      end

      protected

      def build_cells
        #add :main_menu, :name => "journalist/rubric_navigation", :action => :show, :options => {:section => model.parent.id}
        add :sidebar, :name => "journalist/sidebar", :action => :show
      end

    end
  end
end
