module Extensions
  module Content
    module EditableContent
      extend ActiveSupport::Concern

      included do

        field :content
      end

      def to_html(fname = :content)
        RedCloth.new(self.send(fname)).to_html
      end
    end
  end
end
