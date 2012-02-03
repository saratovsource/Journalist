module Journalist
  module Acl
    class PasswordValidator < AclValidator
      
      def initialize(options)
        super
      end
      
      def validate_each(record, attribute, value)
        stored_passwd = record.try(attribute)
        sended_password = record.acl_params[:password]
        record.acl_errors.add(:acl_password, I18n.t("acl.password")) unless sended_password == stored_passwd
      end
      
    end
  end
end