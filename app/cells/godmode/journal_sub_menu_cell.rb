class Godmode::JournalSubMenuCell < ::Godmode::MenuCell
  
  protected
  
  def build_list
    add :rubrics, :url => godmode_journal_rubrics_url, :controllers => [Godmode::JournalRubricsController]
    add :tags, :url => '#'
  end
  
  def build_item(name, attributes)
    item = super
    #item[:controllers] ||= []
    item[:active] = (item[:controllers] && item[:controllers].include?(parent_controller.parent_controller.class))
    item
  end
  
  def localize_label(label)
    I18n.t("godmode.shared.publications_sub_menu.#{label}")
  end
end