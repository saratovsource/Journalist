module Journalist
  class TopMenuCell < ::MenuCell
    protected
    
    def build_list
      add :journal, :url => '#'
      add :reportage, :url => '#'
      add :facepatrol, :url => '#'
      add :columns, :url => '#'
      add :timeline, :url => '#'
    end
    
    def localize_label(label)
      I18n.t("journalist.menu.top_menu.#{label}")
    end
    
  end
end