module Godmode
  class DashboardController < Godmode::BaseController
    skip_load_and_authorize_resource

    sections :dashboard

    def index

    end

    def switch_to
      session[:account_type] = params[:role] if current_account.role_in?(%w(editor admin))
      redirect_to is_redactor? ? prepublished_godmode_journal_articles_path : godmode_journal_articles_path
    end

    protected

    def set_sidebar_menu
      @sidebar_menu = false
    end
  end
end
