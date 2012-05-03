module FacePatrol
  class FacePatrolsController < ::BaseController

    def index
      @faces = current_site.faces
      if params[:sex].present? && %w(boys girls).include?(params[:sex])
        @faces = @faces.send(params[:sex])
      end
      @faces = @faces.desc(:created_at).page(params[:page] || 1).per(params[:per_page] || 8)
      @layout_sections = {
        :main_menu => {
          :name => "journalist/faces_navigation",
          :action => :description
        },
        :sidebar => {
          :name => "journalist/faces_navigation",
          :action => :show
        }
      }
    end

    def sections
      [:face_patrol]
    end

  end
end
