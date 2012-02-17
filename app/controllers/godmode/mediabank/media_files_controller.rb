module Godmode
  module Mediabank
    class MediaFilesController < SpineModelController
      sections :mediabank
      custom_actions :collection => :sort
      before_filter :set_site_and_owner, :only => :create
      belongs_to :media_collection
      respond_to :html, :json
      
      def index
        index! do |format|
          format.json {
            render :json => @media_files.collect{|mf| resource_to_json(mf)}.to_json
          }
          format.html {}
        end
      end
      
      def create
        create! do |format|
          if @media_file.errors.empty?
            format.html {
              render :json => [resource_to_json(@media_file)].to_json,
              :content_type => 'text/html',
              :layout => false
            }
            format.json {
              render :json => [resource_to_json(@media_file)].to_json
            }
          else
            render :json => [{:error => "custom_failure"}], :status => 304
          end
        end
      end
      
      def destroy
        destroy! do |format|
          format.html { render :json => true, :content_type => 'text/html', layout => false }
          format.json { render :json => true }
        end
      end
      
      def sort
        respond_to do |format|
          if current_site.sort(MediaFile, params[:children])
            format.json { render :json => {:compleated => true, :message => {:title => "Sorting", :text => "Success"}}}
          else
            format.json { render :json => {:compleated => false, :message => {:title => "Sorting", :text => "Fails"}}}
          end
        end
      end
      
      protected
      
      def set_site_and_owner
        @media_file.site = current_site
        @media_file.owner = current_account
      end
      
      def resource_to_json(resource)
        {
          "name" => resource.title,
          "size" => resource.file.size,
          "url" => resource.file.url,
          "fullpath" => resource.fullpath,
          "thumbnail_url" => resource.file.mini_thumb.url,
          "delete_url" => resource_url(resource),
          "delete_type" => "DELETE" 
        }
      end
    end
  end
end