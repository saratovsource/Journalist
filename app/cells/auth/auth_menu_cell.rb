module Auth
  class AuthMenuCell < ::MenuCell
    protected

    def build_list
      add :register, :url => new_account_registration_path, :controllers => [RegistrationsController], :action => "new"
      add :sign_in, :url => new_account_session_path, :controllers => [SessionsController], :action => "new"
      add :password_restore, :url => new_account_password_path, :controllers => [PasswordsController], :action => "new"
      #add :help, :url => '#'
    end

    def build_item(name, attributes)
      item = super
      controller_active = false
      action_active = false
      controller_active = (item[:controllers] && item[:controllers].include?(parent_controller.class))
      action_active = (attributes[:action] == parent_controller.action_name) if attributes[:action]
      item[:active] = (controller_active and action_active)
      item
    end

    def localize_label(label)
      I18n.t("journalist.menu.auth.#{label}")
    end
  end
end
