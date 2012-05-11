class ButtonsCell < Cell::Rails
  attr_accessor :model

  def like(model)
    self.model = model
    render
  end
end
