class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  #rescue_from Exception, :with => :render_error
  #
  #def render_error
  #   render :template => "/errors/500", :status => 500
  #end
end