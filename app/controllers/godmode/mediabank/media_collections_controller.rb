module Godmode
  module Mediabank
    class MediaCollectionsController < SpineModelController
      custom_actions :resource => [:add_files, :descriptions]
      sections :mediabank
      before_filter :set_site_and_owner, :only => :create
      
      def create
        create!{ godmode_mediabank_media_collections_url}
      end
      
      def update
        update!{ godmode_mediabank_media_collection_path(@media_collection) }
      end
            
      def add_files
        
      end
      
      protected
      
      def set_site_and_owner
        @media_collection.site = current_site
        @media_collection.owner = current_account
      end
      
    end
  end
end