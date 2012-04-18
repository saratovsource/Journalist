module Journalist
  class RubricNavigationCell < ::MenuCell

    protected

    def build_list
      add :all, :url => '#'
      current_site.journal_rubrics.each do |rubric|
        add rubric.title, :url => rubric.router.fullpath
      end
    end

    def localize_label(label)
      case label
      when Symbol
        I18n.t("journalist.menu.rubric_navigation.#{label}")
      else
        label
      end
    end

  end
end
