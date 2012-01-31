module Godmode
  class AccountsController < BaseController
    custom_actions :resource => [:articles]
    
    sections :publications
    
    def articles
      unless session[:account_type] == "editor"
        @collection = current_site.journal_articles.owned(current_account).must_publish
      else
        @collection = @account.journal_articles.must_publish
      end
    end
    
    def new
      @account = Account.new(:email => params[:email])
    end
    
    def create
      @account = Account.create(params[:account])
      current_site.memberships.create(:account => @account) if @account.errors.empty?
      
      respond_with @account, :location => edit_godmode_current_site_url
    end
  end
end