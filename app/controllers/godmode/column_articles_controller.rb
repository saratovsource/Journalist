class Godmode::ColumnArticlesController < Godmode::BaseController

  sections :publications

  def begin_of_association_chain
    current_account.column
  end

end
