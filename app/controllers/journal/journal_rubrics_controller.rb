module Journal
  class JournalRubricsController < ::BaseController
    #include Journalist::ProductionResource

    def index
      @journal_rubrics = current_site.journal_rubrics
      @articles = current_site.journal_articles.with_state(:published).page(params[:page]).per(params[:per_page])
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
