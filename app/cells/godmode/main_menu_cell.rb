class Godmode::MainMenuCell < ::Godmode::MenuCell
  
  protected

  def build_list
    add :publications, :url => godmode_journal_articles_url, :css_class => 'publications'
    add :mediabank, :url => '#', :css_class => 'mediabank'
    #add :contents, :url => admin_pages_url
    #add :settings, :url => edit_admin_current_site_url
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