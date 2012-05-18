class Journalist::CommentsCell < ::MenuCell
  attr_accessor :commentable, :collection

  def show(commentable, collection)
    self.commentable = commentable
    self.collection = collection
    render
  end

  protected

  def build_list
  end

end
