class Godmode::MainMenuCell < ::Godmode::MenuCell
  
  protected

  def build_list
    add :journal_articles, :url => '#', :css_class => 'publications'
    add :mediabank, :url => '#', :css_class => 'mediabank'
    #add :contents, :url => admin_pages_url
    #add :settings, :url => edit_admin_current_site_url
  end
end