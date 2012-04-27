class Godmode::ColumnArticlesController < Godmode::BaseController

  sections :publications

  def empty
    @column_article = ColumnArticle.create_new( :site => current_site, :owner => current_account )
    redirect_to edit_godmode_column_article_path(@column_article)
  end

  protected

  def collection
    @column_articles ||= end_of_association_chain
  end
end
