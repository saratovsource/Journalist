module Journalist
  class RubricNavigationCell < ::MenuCell

    def widget(args = {})
      self.options = args
      @current_site = current_site
      @posts_count = current_site.journal_articles.published.count
      @rubrics = current_site.journal_rubrics.select{|i| i.journal_articles.published.count > 0}
      @rubrics_count = @rubrics.count
      render
    end

    protected

    def build_list
      add :all, :url => journal_root_path, :active => !options[:section].present?
      current_site.journal_rubrics.select{|i| i.journal_articles.published.count > 0}.each do |rubric|
        add rubric.title, :url => rubric.router.fullpath, :active => options[:section] == rubric.id
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
