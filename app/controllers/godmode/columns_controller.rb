class Godmode::ColumnsController < Godmode::BaseController

  def create
    @column = current_site.columns.build(:owner => current_account)
    create! do |success, failure|
      success.html{ redirect_to godmode_column_articles_path }
      failure.html{ redirect_to godmode_column_articles_path }
    end
  end
end
