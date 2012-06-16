module Reportages
  class ReportagesController < ::BaseController


    def index
      @layout_sections = {
      }

      last_item = current_site.reportages.with_state(:published).desc(:created_at).first
      redirect_to last_item.present? ? last_item.fullpath : root_path
    end

    def sections
      [:reportage_patrol]
    end
  end
end
