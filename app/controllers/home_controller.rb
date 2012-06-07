class HomeController < ::BaseController

  layout "home"

  def index
    #@items = tabs_filter(current_site.time_lines.feed, params[:tab]).page(params[:page]).per(10).map(&:timelinable).compact
  end

  def sections
    []
  end

end
