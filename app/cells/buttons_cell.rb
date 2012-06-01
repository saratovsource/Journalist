class ButtonsCell < Cell::Rails
  attr_accessor :model, :liked, :active_section

  def like(model, liked = false)
    self.model = model
    self.liked = liked
    render
  end

  def profile_tabs(active_section)
    self.active_section = active_section
    render
  end
end
