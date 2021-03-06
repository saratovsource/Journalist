require 'sanitize'
module Journalist
  module TextUtils

    # This util get text as input and return Hash of links to routerable objects
    # in return hash:
    # keys - are links
    # values - routes
    class RouteLinksBrowser < Hash
      attr_accessor :content, :options
      DEFAULTS = {
        :slice_host => true
      }

      def initialize(content, args = {})
        @content = Sanitize.clean(content)
        @options = DEFAULTS.merge(args)

        retrive_links
      end

      protected

      def retrive_links
        if current_site = @options[:site]
          retrive_uris.select{|uri|
            if retrived_object = current_site.find_object_by_path(uri.path)
              self[@options[:slice_host] ? uri.path : uri.to_s] = retrived_object
            end
            }
        end
      end

      def retrive_uris
        LinksBrowser.new(@content).collect{|i| URI(i)}
      end

      def slice_host?
        @options[:slice_host]
      end
    end
  end
end
