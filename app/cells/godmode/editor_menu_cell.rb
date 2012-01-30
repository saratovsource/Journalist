class Godmode::EditorMenuCell < ::Godmode::MenuCell
  
  protected
  
  def build_list
    add :comments, :url => '#'
    add :feedback, :url => '#'
  end
end