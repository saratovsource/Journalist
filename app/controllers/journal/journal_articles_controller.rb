module Journal
  class JournalArticlesController < InheritedResources::Base
    include Journalist::ProductionResource
    
  end
end