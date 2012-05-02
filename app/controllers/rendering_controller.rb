class RenderingController < ::BaseController#ApplicationController
  #include Journalist::Routing::SiteDispatcher
  before_filter :retrive_route_object

  def show
    @page_class = css_class_from(@routerable)
    @comments = @routerable.comments || []
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
