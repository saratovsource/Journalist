module Journalist
  class FacesNavigationCell < ::MenuCell

    def description(args = {})
      self.options = args
      render
    end

    def tabs(args = {})
      self.options = args
      render
    end

    def widget(args={})
      self.options = args
      # retrive random facepatrol
      @random_counts = self.options[:count] || 1
      @faces = current_site.faces
      @face = (0..@faces.count-1).sort_by{rand}.slice(0, @random_counts).collect! do |i| @faces.skip(i).first end.first
      render
    end

    protected

    def build_list
    end
  end
end
