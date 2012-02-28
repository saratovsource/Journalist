module Godmode
  class MembershipsController < BaseController
    sections :accounts
    
    def update
      update!{ godmode_accounts_url }
    end
  end
end