module Godmode
  class JournalArticlesController < BaseController
    custom_actions :collection => [:empty, :prepublished, :published, :tags]
    before_filter :set_parent_class
    
    sections :publications
    
    def empty
      @journal_article = JournalArticle.create_new( :site => current_site, :owner => current_account )
      redirect_to edit_godmode_journal_article_path(@journal_article)
    end
    
    def update
      update! do |format|
        @journal_article.send(params[:after_action]) unless params[:after_action].blank? #Try send action
        if @journal_article.errors.empty?
          format.html { redirect_to is_redactor? ? prepublished_godmode_journal_articles_path : collection_url(:state => @journal_article.state) }
        end
      end
    end
    
    def tags
     @tags = resource_class.tags_with_weight
    end
    
    protected
    
    def collection
      where_params = { :site_id => current_site.id }
      
      #Sort By State
      unless params[:state].blank?
        states = states_from_params(params[:state])
      else
        states = resource_class.state_machines[:state].states.keys
      end
      states = states.compact
      if is_redactor?
        @collection ||= current_site.journal_articles.with_states([:prepublished, :published])
      else
        @collection ||= end_of_association_chain.where(where_params).with_states(states.compact)
      end
    end
    
    def resource
      if is_redactor?
        @resource = current_site.journal_articles.find(params[:id])
      else
        super
      end
    end
    
    def begin_of_association_chain
      current_account
    end
    
    def set_parent_class
      @parent_class = JournalRubric
    end
    
    def states_from_params(state)
      states = []
      if %w(drafted rewrited).include?(state)
        states << :drafted << :rewrited 
      else
        states << state
      end
      states
    end
    
  end
end