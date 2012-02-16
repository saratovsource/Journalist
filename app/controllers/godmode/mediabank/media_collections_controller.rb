module Godmode
  module Mediabank
    class MediaCollectionsController < SpineModelController
      custom_actions :resource => [:add_files]
      sections :mediabank
      before_filter :set_site_and_owner, :only => :create
      
      def create
        create!{ godmode_mediabank_media_collections_url}
      end
      
      def update
        update! do |success, failure|
          success.html { redirect_to godmode_mediabank_media_collections_path }
          failure.html { redirect_to godmode_mediabank_media_collection(@media_collection) }
        end
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