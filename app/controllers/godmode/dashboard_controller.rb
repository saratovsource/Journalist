module Godmode
  class DashboardController < BaseController
    skip_load_and_authorize_resource
    
    sections :dashboard
    
    def index
      
    end
    
    protected
    
    def set_sidebar_menu
      @sidebar_menu = false
    end
  end
end