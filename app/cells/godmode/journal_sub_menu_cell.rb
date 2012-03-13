class Godmode::JournalSubMenuCell < ::MenuCell
  
  protected
  
  def build_list
    abil = Ability.new(current_account, current_site)
    add :rubrics, :url => godmode_journal_rubrics_url, :controllers => [Godmode::JournalRubricsController] if abil.can? :manage, JournalRubric
    add :tags, :url => tags_godmode_journal_articles_path, :action => "tags"
  end
  
  def build_item(name, attributes)
    item = super
    controller_active = false
    action_active = false
    controller_active = (item[:controllers] && item[:controllers].include?(parent_controller.parent_controller.class))
    action_active = (attributes[:action] == parent_controller.parent_controller.action_name) if attributes[:action]
    item[:active] = (controller_active or action_active)
    item
  end
  
  def localize_label(label)
    I18n.t("godmode.shared.publications_sub_menu.#{label}")
  end
end