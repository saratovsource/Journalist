class ApplicationController < ActionController::Base
  include Journalist::Routing::SiteDispatcher

  protect_from_forgery

  layout "journalist"

  protected

  def journalist_layout
   request.xhr? ? false : "journalist"
  end
end
