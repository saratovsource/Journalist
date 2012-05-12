class RenderingController < ::BaseController#ApplicationController
  #include Journalist::Routing::SiteDispatcher
  before_filter :retrive_route_object

  def show
    @page_class = css_class_from(@routerable)
    @comments = @routerable.comments || []

    if params.has_key? :like
      @routerable.rate_and_save(1, @rater) unless @routerable.rated_by?(@rater)
      render :text => (render_cell "buttons", :like, @routerable)
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
    @rater = Rater.find_or_create_by(:ip_address => request.env['REMOTE_ADDR'], :site_id => current_site.id)
  end

  def css_class_from(object)
    case object
    when MediaCollection then "mediapage"
    else "page"
    end
  end

end
