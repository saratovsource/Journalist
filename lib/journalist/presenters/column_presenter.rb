module Journalist
  module Presenters
    class ColumnPresenter < Presenter

      def sections
        [:columns]
      end

      protected

      def build_cells
        add :main_menu, :name => "journalist/columns_navigation", :action => :description_me, :options => {:section => model.parent.id, :model => model}
        add :sidebar, :name => "journalist/columns_navigation", :action => :show_me, :options => {:model => model}
        add :comments, :name => "journalist/comments", :action => :show, :options => {:model => model}
      end

    end
  end
end
