class HomeController < ::BaseController

  def index
    @items = TimeLine.feed.page(params[:page]).per(10).map(&:timelinable).compact
  end

  def sections
    []
  end

end
