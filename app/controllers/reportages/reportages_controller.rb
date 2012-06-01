module Reportages
  class ReportagesController < ::BaseController


    def index
      @reportages = current_site.reportages
      @reportages = @reportages.desc(:created_at).page(params[:page] || 1).per(params[:per_page] || 8)
      @layout_sections = {
      }

      redirect_to @reportages.first.fullpath
    end

    def sections
      [:reportage_patrol]
    end
  end
end
