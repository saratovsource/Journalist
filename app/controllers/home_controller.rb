class HomeController < ::BaseController

  def index
    @items = TimeLine.feed.page(params[:page]).per(10).map(&:timelinable)
  end

  def sections
    []
  end

end
