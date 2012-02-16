module Godmode
  module Mediabank
    class SpineModelController < ::Godmode::BaseController
      layout :change_layout
      respond_to :html, :json
      
      def destroy
        destroy! do |success, failure|
          success.json { head :ok }
          failure.json { head :false }
        end
      end      
      def change_layout
        request.xhr? ? false : "godmode"
      end
    end
  end
end