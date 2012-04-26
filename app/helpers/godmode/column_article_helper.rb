module Godmode::ColumnArticleHelper
  def has_column?
    current_account.column.present?
  end
end
