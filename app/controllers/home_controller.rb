class HomeController < ActionController::Base
  include Journalist::Routing::SiteDispatcher
  
  before_filter :require_site
  
  def index
    
  end
  
  def search_path
    
  end
  
end