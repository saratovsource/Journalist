Dir[File.join(File.dirname(__FILE__), 'acl/*.rb')].each { |lib| require lib }
module Journalist
  module Acl
    extend ActiveSupport::Concern
    
    included do
      
    end
    
    module ClassMethods
      def acl_validators=(value)
        @acl_validators = value
      end
      
      def acl_validators
        @acl_validators
      end
      
      def acl_validates_with(*args, &block)
        self.acl_validators ||= []
        options = args.extract_options!
        args.each do |klass|
          acl_validator = klass.new(options, &block)
          acl_validator.setup(self) if acl_validator.respond_to?(:setup)
          self.acl_validators << acl_validator
        end
      end
    end
    
    module InstanceMethods
      attr_accessor :acl_params
      
      def acl_errors
        @acl_errors ||= ActiveModel::Errors.new(self)
        @acl_errors
      end
      
      def acl_valid?(params = {})
        self.acl_params = params
        acl_validate!
        self.acl_errors.empty?
      end
      
      def acl_validate!
        self.acl_errors.clear
        self.class.acl_validators.each do |acl_validator|
          acl_validator.validate(self)
        end
      end
      
      def acls_instances
        self.class.acl_validators
      end
      
      def acls
        @acls ||= acls_instances.collect{|validator| validator.kind}
        @acls
      end
      
      def acl_protecteds
        @protected_fields = []
        acls_instances.each do |validator|
          @protected_fields << validator if validator.protected?(self)
        end
        @protected_fields
      end
      
      def acl_protected?
        !acl_protecteds.empty?
      end
    end
  end
end