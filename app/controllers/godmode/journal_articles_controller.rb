module Godmode
  class JournalArticlesController < BaseController
    custom_actions :collection => :empty
    
    sections :publications
    
    def empty
      raise "Not implemented"
    end
  end
end