class BaseController < ApplicationController
  include Journalist::Routing::SiteDispatcher
  include Journalist::Routing::BaseController

  before_filter :set_default_sections

  def sections
    []
  end

  protected

  def set_default_sections
    @layout_sections = {
      :sidebar => {
        :name => "journalist/faces_navigation",
        :action => :widget,
        :options => {:current_site => current_site}
      }
    }
  end

end
