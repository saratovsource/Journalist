module Journal
  class CommentsController < InheritedResources::Base
    include Journalist::ProductionResource
    
  end
end