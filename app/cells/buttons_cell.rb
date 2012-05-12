class ButtonsCell < Cell::Rails
  attr_accessor :model, :liked

  def like(model, liked = false)
    self.model = model
    self.liked = liked
    render
  end
end
