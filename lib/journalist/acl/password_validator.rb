module Journalist
  module Acl
    class PasswordValidator < AclValidator
      
      def validate_each(record, attribute, value)
        if protected?(record)
          stored_passwd = record.try(attribute)
          sended_password = record.acl_params[:password]
          record.acl_errors.add(:acl_password, I18n.t("acl.password")) unless sended_password == stored_passwd
        end
      end
      
      def protected?(record)
        stored_passwd = record.try(:acl_password)
        return !(stored_passwd.nil? or stored_passwd.blank?)
      end
      
    end
  end
end