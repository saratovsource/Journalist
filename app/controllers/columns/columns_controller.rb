module Columns
  class ColumnsController < ::BaseController

    def index
      @columns = Column.all
      @column_articles = current_site.column_articles.feed.with_state(:published)
      @column_articles = tabs_filter(@column_articles, params[:tab]).page(params[:page]).per(params[:per_page])
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
