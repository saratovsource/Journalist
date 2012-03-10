module Journalist
  module TextUtils
    # Get links array from text
    class LinksBrowser < Array
      REGEXP = %r{(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/\~\+#]*[\w\-\@?^=%&amp;\/\~\+#])?}
      attr_accessor :text
      
      def initialize(text)
        @text = text
        retrive_links
      end
      
      protected
      
      def retrive_links
        concat(@text.gsub(REGEXP).to_a)
      end
    end
  end
end