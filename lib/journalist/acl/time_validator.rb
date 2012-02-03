module Journalist
  module Acl
    class TimeValidator < AclValidator
      
      def validate_each(record, attribute, value)
        if protected?(record)
          range = access_time_range(record.try(:acl_time_start), record.try(:acl_time_end))
          record.acl_errors.add(:acl_time_range, I18n.t("acl.acl_time_range")) unless range.include?(Time.now.to_i)
        end
      end
      
      def protected?(record)
        stored_attributes = %w(acl_time_start acl_time_end).collect{|field| record.try(field)}.reject(&:blank?)
        return !stored_attributes.empty?
      end
      
      protected
      
      def access_time_range(time_start, time_end)
        time_start = "00:00" if time_start.blank?
        time_end = "24:00" if time_end.blank?
        range = (Time.parse(time_start).to_i..Time.parse(time_end).to_i)
      end
      
    end
  end
end