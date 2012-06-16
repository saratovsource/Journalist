module Journalist
  class StaticPagesCell < ::MenuCell
    
    def footer
      show
    end

    protected

    def build_list
      Page.web.each do |page|
        add page.title, :url => page.fullpath
      end
    end

    def localize_label(label)
      label
    end
  end
end
