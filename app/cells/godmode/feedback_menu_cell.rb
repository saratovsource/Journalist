class Godmode::FeedbackMenuCell < ::MenuCell

  protected

  def build_list
    add :comments, :url => godmode_comments_path, :controllers => [Godmode::CommentsController]
  end

  def localize_label(label)
    I18n.t("godmode.shared.sub_menu.#{label}")
  end
end
