module Journalist
  class TopMenuCell < ::MenuCell

    def footer
      show
    end

    protected

    def build_list
      add :journal, :url => journal_root_path, :active => sections.include?(:journal)
      add :reportage, :url => '#'
      add :facepatrol, :url => face_patrol_root_path, :active => sections.include?(:face_patrol)
      add :columns, :url => columns_root_path, :active => sections.include?(:columns)
      add :timeline, :url => timeline_root_path, :active => sections.include?(:timeline)
    end

    def localize_label(label)
      I18n.t("journalist.menu.top_menu.#{label}")
    end

  end
end
