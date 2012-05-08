module Timeline
  class TimelinesController < ::BaseController

    layout "journalist_timeline"

    def index
      @items = current_site.time_lines.feed.page(params[:page]).per(params[:per]).map(&:timelinable).compact
      @layout_sections = {
        :main_menu => {
          :name => "journalist/timeline",
          :action => :description
        },
        :timeline => {
          :name => "journalist/timeline",
          :action => :dayline
        },
        :sidebar => {
          :name => "journalist/faces_navigation",
          :action => :widget,
          :options => {:current_site => current_site}
        }
      }
    end

    def sections
      [:timeline]
    end

  end
end
