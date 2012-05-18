module Journalist
  class ColumnsNavigationCell < ::MenuCell

    def description(args = {})
      self.options = args
      render
    end

    def show_me(args = {})
      self.options = args
      render
    end

    def description_me(args = {})
      self.options = args
      render
    end

    def widget(args = {})
      self.options = args
      @current_site = current_site
      @posts_count = current_site.column_articles.published.count
      @columns = current_site.columns.select{|i| i.column_articles.published.count > 0}[0..5]
      render
    end

    protected

    def build_list
      current_site.columns.each do |item|
        add item.title, :resource => item
      end
    end

    def localize_label(label)
      case label
      when Symbol
        I18n.t("journalist.menu.columns.#{label}")
      else
        label
      end
    end

  end
end
