class Godmode::AccountsMenuCell < ::Godmode::MenuCell
  protected
  
  def build_list
    add :redaction, :url => '#'
    add :others, :url => '#'
  end
  
  def localize_label(label)
    I18n.t("godmode.shared.sub_menu.#{label}")
  end
end