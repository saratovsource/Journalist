class Godmode::PublicationsMenuCell < ::MenuCell
  protected

  def build_list
    add :journal, :url => godmode_journal_articles_path, :controllers => [Godmode::JournalRubricsController, Godmode::JournalArticlesController]
    add :face_patrol, :url => godmode_faces_path, :controllers => [Godmode::FacesController]
    add :reportage, :url => godmode_reportages_path, :controllers => [Godmode::ReportagesController]
    add :columns, :url => godmode_column_articles_path, :controllers => [Godmode::ColumnArticlesController]
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
