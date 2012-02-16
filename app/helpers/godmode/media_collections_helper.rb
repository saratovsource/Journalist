module Godmode
  module MediaCollectionsHelper
    
    def author_list
      select_tag(
          :media_user, 
          options_for_select(current_site.godmode_accounts.collect{|acc| [acc.name, acc.id]}, current_media_user.id), 
          :class => "span6"
        )
    end
    
    def current_media_user
      current_account
      #session[:media_user] ||= current_account
      #return session[:media_user]
    end
    
  end
end