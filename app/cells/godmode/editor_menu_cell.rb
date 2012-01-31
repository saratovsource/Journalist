class Godmode::EditorMenuCell < ::Godmode::MenuCell
  
  protected
  
  def build_list
    add :journal,   :url => prepublished_godmode_journal_articles_path
    add :comments,  :url => '#'
    add :feedback,  :url => '#'
  end
end