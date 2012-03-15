module Journal
  class JournalRubricsController < InheritedResources::Base
    include Journalist::ProductionResource

  end
end