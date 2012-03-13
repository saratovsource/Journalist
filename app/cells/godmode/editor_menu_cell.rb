class Godmode::EditorMenuCell < ::MenuCell
  
  protected
  
  def build_list
    add :journal,   :url => prepublished_godmode_journal_articles_path, :controllers => [Godmode::JournalArticlesController]
    add :comments,  :url => '#'
    add :feedback,  :url => '#'
  end
  
  def build_item(name, attributes)
    item = super
    item[:expanded] = (item[:controllers] && item[:controllers].include?(parent_controller.class))
    item
  end
end