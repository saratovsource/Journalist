module Godmode
  class JournalRubricsController < BaseController
    custom_actions :resource => :empty, :collection => :sort
    respond_to :html, :json
    
    sections :publications
    
    def empty
      @journal_rubric = JournalRubric.create_new( :site => current_site, :owner => current_account )
      redirect_to edit_godmode_journal_rubric_path(@journal_rubric)
    end
    
    def sort
      p params[:children]
      respond_to do |format|
        if current_site.sort(JournalRubric, params[:children])
          format.json { render :json => {:compleated => true, :message => {:title => "Sorting", :text => "Success"}}}
        else
          format.json { render :json => {:compleated => false, :message => {:title => "Sorting", :text => "Fails"}}}
        end
      end
    end
  end
end