class Godmode::AccountsController < Godmode::BaseController
  custom_actions :resource => [:articles, :change_user]

  sections :accounts

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

  def update
    update!{collection_url}
  end

  def create
    @account = Account.create(params[:account])
    current_site.memberships.create(:account => @account) if @account.errors.empty?

    respond_with @account, :location => edit_godmode_current_site_url
  end

  def change_user
    change_user! do |format|
      session[:mediabank_user] = @account.id
      format.html{ redirect_to godmode_mediabank_root_path}
    end
  end

  protected

  def collection
    where_params = { :site_id => current_site.id }
    @collection ||= current_site.accounts.page(params[:page]).per(params[:per_page])
  end
end
