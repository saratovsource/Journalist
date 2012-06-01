module Extensions
  module Site
    module IncludedIn

      extend ActiveSupport::Concern

      included do
        # -= Associations =-
        belongs_to :site
        belongs_to :presentable, polymorphic: true

        # -= Indexes=-
        index :site_id

        # -= Validations =-
        validates_presence_of :site
      end

    end
  end
end
