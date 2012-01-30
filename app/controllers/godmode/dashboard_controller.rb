module Godmode
  class DashboardController < BaseController
    skip_load_and_authorize_resource
    
    sections :dashboard
    
    def index
      
    end
    
    def switch_to
      session[:account_type] = params[:role] if current_account.role_in?(%w(editor admin))
      redirect_to :back
    end
    
    protected
    
    def set_sidebar_menu
      @sidebar_menu = false
    end
  end
end