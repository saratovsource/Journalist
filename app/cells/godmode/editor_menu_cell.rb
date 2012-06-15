class Godmode::EditorMenuCell < ::MenuCell

  protected

  def build_list
    add :journal,   :url => prepublished_godmode_journal_articles_path, :controllers => [Godmode::JournalArticlesController]
    add :face_patrol, :url => prepublished_godmode_faces_path, :controllers => [Godmode::FacesController]
    add :comments,  :url => '#'
    add :labels,    :url => godmode_labels_path, :controllers => [Godmode::LabelsController]
    add :pages,     :url => godmode_pages_path, :controllers => [Godmode::PagesController]
  end

  def build_item(name, attributes)
    item = super
    item[:expanded] = (item[:controllers] && item[:controllers].include?(parent_controller.class))
    item
  end
end
