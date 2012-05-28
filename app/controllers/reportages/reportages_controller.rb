module Reportages
  class ReportagesController < ::BaseController


    def index
      @reportages = current_site.reportages
      @reportages = @reportages.desc(:created_at).page(params[:page] || 1).per(params[:per_page] || 8)
      @layout_sections = {
        :main_menu => {
          :name => "journalist/reportages_navigation",
          :action => :description
        },
        :sidebar => {
          :name => "journalist/reportages_navigation",
          :action => :show
        }
      }
    end

    def sections
      [:reportage_patrol]
    end
  end
end
