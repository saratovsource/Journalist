module Godmode
  module MediaCollectionsHelper
    
    def author_list
      select_tag(
          :media_user, 
          options_for_select(current_site.godmode_accounts.collect{|acc| [acc.name, acc.id]}, current_media_user.id), 
          :class => "span6",
          :data => {:media_account => godmode_accounts_path, :postfix => "change_user"}
        )
    end
    
    def read_only?
      current_media_user != current_account
    end
    
    def current_media_user
      user = nil
      user = current_site.accounts.find(session[:mediabank_user].to_s) if session[:mediabank_user]
      user || current_account
    end
    
  end
end