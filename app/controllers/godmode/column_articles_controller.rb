class Godmode::ColumnArticlesController < Godmode::BaseController

  sections :publications

  protected

  def collection
    @column_articles ||= end_of_association_chain
  end
end
