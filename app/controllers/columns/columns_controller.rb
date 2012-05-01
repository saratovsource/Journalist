module Columns
  class ColumnsController < ::BaseController

    def index
      @columns = Column.all
      @column_articles = current_site.column_articles.with_state(:published)
      @layout_sections = {
        :main_menu => {
          :name => "journalist/columns_navigation",
          :action => :description
        },
        :sidebar => {
          :name => "journalist/columns_navigation",
          :action => :show
        }
      }
    end

    def sections
      [:columns]
    end
  end
end
