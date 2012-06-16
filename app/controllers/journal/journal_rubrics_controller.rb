module Journal
  class JournalRubricsController < ::BaseController
    #include Journalist::ProductionResource

    def index
      @journal_rubrics = current_site.journal_rubrics
      @articles = tabs_filter(current_site.journal_articles.published, params[:tab]).page(params[:page]).per(params[:per_page] || 1)
      @layout_sections = {
        :main_menu => {
          :name => "journalist/rubric_navigation",
          :action => :show
        },
        :sidebar => {
          :name => "journalist/faces_navigation",
          :action => :widget,
          :options => {:current_site => current_site}
        }
      }
    end

    def sections
      [:journal]
    end

  end
end
