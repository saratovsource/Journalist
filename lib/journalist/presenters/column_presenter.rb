module Journalist
  module Presenters
    class ColumnPresenter < Presenter

      protected

      def build_cells
        add :main_menu, :name => "journalist/columns_navigation", :action => :description, :options => {:section => model.parent.id}
        add :sidebar, :name => "journalist/columns_navigation", :action => :show
      end

    end
  end
end
