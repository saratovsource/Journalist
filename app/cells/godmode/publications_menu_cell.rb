class Godmode::PublicationsMenuCell < ::Godmode::MenuCell
  protected
  
  def build_list
    add :journal, :url => godmode_journal_articles_url, :controllers => [Godmode::JournalRubricsController, Godmode::JournalArticlesController]
    add :photo, :url => '#', :controllers => []
    add :face_patrol, :url => '#', :controllers => []
    add :columns, :url => '#', :controllers => []
  end
  
  def build_item(name, attributes)
    item = super
    item[:expanded] = (item[:controllers] && item[:controllers].include?(parent_controller.class))
    item
  end
  
  def localize_label(label)
    I18n.t("godmode.shared.sub_menu.#{label}")
  end
end