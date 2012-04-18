class ApplicationController < ActionController::Base
  include Journalist::Routing::SiteDispatcher

  protect_from_forgery

  layout "journalist"
end
