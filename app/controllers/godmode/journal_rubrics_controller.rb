module Godmode
  class JournalRubricsController < BaseController
    custom_actions :resource => :empty
    
    sections :publications
    
    def empty
      @journal_rubric = JournalRubric.create_new( :site => current_site, :owner => current_account )
      redirect_to edit_godmode_journal_rubric_path(@journal_rubric)
    end
  end
end