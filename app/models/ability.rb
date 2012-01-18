class Ability
  include CanCan::Ability
  
  ROLES = %w(admin editor author guest)
  
  def initialize(account, site)
    @account, @site = account, site
    
    alias_action :index, :show, :edit, :update, :to => :touch
    
    @membership = @site.memberships.where(:account_id => @account.id).first
    
    return false if @membership.blank?
    
    
  end
end