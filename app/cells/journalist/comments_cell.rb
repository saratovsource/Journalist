class Journalist::CommentsCell < ::MenuCell
  attr_accessor :commentable, :collection

  def show(args = {})
    self.options = args.merge(:can_post => current_account.present?)
    render
  end

  def form(args = {})
    self.options = args
    render
  end

  protected

  def build_list
  end

end
