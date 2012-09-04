class Godmode::EditorMenuCell < ::MenuCell

  protected

  def build_list
    abil = Ability.new(current_account, current_site)
    add :journal,   :url => prepublished_godmode_journal_articles_path, :controllers => [Godmode::JournalArticlesController] if abil.can? :manage, JournalArticle
    add :face_patrol, :url => prepublished_godmode_faces_path, :controllers => [Godmode::FacesController] if abil.can? :manage, Face
    add :labels,    :url => godmode_labels_path, :controllers => [Godmode::LabelsController] if abil.can? :manage, Label
    add :pages,     :url => godmode_pages_path, :controllers => [Godmode::PagesController] if abil.can? :manage, Page
  end

  def build_item(name, attributes)
    item = super
    item[:expanded] = (item[:controllers] && item[:controllers].include?(parent_controller.class))
    item
  end
end
