module Journalist
  module Acl
    class AclValidator < ::ActiveModel::EachValidator
      
      def protected?(record)
        raise "Not implemented! Override!"
      end
    end
  end
end