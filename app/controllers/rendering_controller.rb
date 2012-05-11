class RenderingController < ::BaseController#ApplicationController
  #include Journalist::Routing::SiteDispatcher
  before_filter :retrive_route_object

  def show
    @page_class = css_class_from(@routerable)
    @comments = @routerable.comments || []

    if params.has_key? :like
      p "TRY_RATING"
      @rater = Rater.find_or_create_by(:ip_address => request.env['REMOTE_ADDR'], :site_id => current_site.id)
      p @rater.inspect
      @routerable.rate_and_save(1, @rater)
      p @routerable.rated?
    end
  end

  def sections
    @presenter.sections || []
  end

  protected

  def retrive_route_object
    @routerable = current_site.find_object_by_path("/#{params[:path]}") if params[:path]
    @presenter = Journalist::Presenters::Presenter.build(@routerable)
    @layout_sections = @presenter.cells if @presenter.present?
  end

  def css_class_from(object)
    case object
    when MediaCollection then "mediapage"
    else "page"
    end
  end

end
