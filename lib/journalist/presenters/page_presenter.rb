module Journalist
  module Presenters
    class PagePresenter < Presenter

      def sections
        []
      end

      protected

      def build_cells
        #add :main_menu, :name => "journalist/rubric_navigation", :action => :show, :options => {:section => model.parent.id}
      end
      
    end
  end
end
