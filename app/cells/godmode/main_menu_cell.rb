class Godmode::MainMenuCell < ::MenuCell

  protected

  def build_list
    add_main_menu_item :publications, godmode_journal_articles_url, 'publications'
    add_main_menu_item :mediabank,    godmode_mediabank_root_url,   'mediabank'
    add_main_menu_item :accounts,     godmode_accounts_url,         'users' if ability.can?(:manage, Account)
    add_main_menu_item :feedback,     godmode_comments_url,         'users' if ability.can?(:manage, Comment)
  end

  def add_main_menu_item(name, path, klazz)
    add name, :url => path, :css_class => klazz
  end

  def build_item(name, attributes)
    item = super
    first_array = [name]
    enhanced_class = "main_menu_section"
    unless sections.blank?
      second_array = [sections].flatten
      unless (first_array & second_array).empty?
        enhanced_class = "#{enhanced_class} active"
        self.active_item = item
      end
    end
    item.merge(:li_class => enhanced_class)
  end
end
