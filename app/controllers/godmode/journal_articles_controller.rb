module Godmode
  class JournalArticlesController < BaseController
    custom_actions :collection => :empty
    before_filter :set_parent_class
    
    sections :publications
    
    def empty
      @journal_article = JournalArticle.create_new( :site => current_site, :owner => current_account )
      redirect_to edit_godmode_journal_article_path(@journal_article)
    end
    
    def update
      update!{ collection_url(:state => @journal_article.state) }
    end
    
    protected
    
    def collection
      unless params[:state].blank?
        states = (params[:state] == :drafted) ? [:rewrited] : []
        states << params[:state]
      else
        states = resource_class.state_machines[:state].states.keys
      end
      @collection ||= end_of_association_chain.where(:site_id => current_site.id).with_states(states.compact)
    end
    
    def begin_of_association_chain
      current_account
    end
    
    def set_parent_class
      @parent_class = JournalRubric
    end
    
  end
end