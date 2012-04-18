module Journal
  class JournalRubricsController < ::BaseController
    include Journalist::ProductionResource

    def index
      @journal_rubrics = current_site.journal_rubrics
    end

  end
end
