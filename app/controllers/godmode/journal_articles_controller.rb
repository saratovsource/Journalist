module Godmode
  class JournalArticlesController < BaseController
    custom_actions :collection => :empty
    
    sections :publications
    
    def empty
      @journal_article = JournalArticle.create_new( :site => current_site, :owner => current_account )
      redirect_to edit_godmode_journal_article_path(@journal_article)
    end
  end
end