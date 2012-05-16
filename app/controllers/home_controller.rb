class HomeController < ::BaseController

  def index
    @items = tabs_filter(current_site.time_lines.feed, params[:tab]).page(params[:page]).per(10).map(&:timelinable).compact
    @layout_sections = {
      :sidebar => {
        :name => "journalist/faces_navigation",
        :action => :widget,
        :options => {:current_site => current_site}
      }
    }
  end

  def sections
    []
  end

end
