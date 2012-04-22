module Journal
  class JournalRubricsController < ::BaseController
    #include Journalist::ProductionResource

    def index
      @journal_rubrics = current_site.journal_rubrics
      @articles = JournalArticle.with_state(:published).page(params[:page]).per(params[:per_page])
      @layout_sections = {
        :main_menu => {
          :name => "journalist/rubric_navigation",
          :action => :show
        }
      }
    end

    def sections
      [:journal]
    end

  end
end
