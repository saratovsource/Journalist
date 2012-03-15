class RenderingController < ApplicationController
  include Journalist::Routing::SiteDispatcher
  before_filter :retrive_route_object
  layout "journalist"
  
  def show
    @page_class = css_class_from(@routerable)
  end
  
  protected
  
  def retrive_route_object
    @routerable = current_site.find_object_by_path("/#{params[:path]}") if params[:path]
  end
  
  def css_class_from(object)
    case object
    when MediaCollection then "mediapage"
    else "page"
    end
  end
  
end