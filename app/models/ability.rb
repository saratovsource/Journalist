class Ability
  include CanCan::Ability
  
  ROLES = %w(admin editor author guest)
  
  def initialize(account, site)
    @account, @site = account, site
    
    alias_action :index, :show, :edit, :update, :to => :touch
    
    @membership = @site.memberships.where(:account_id => @account.id).first
    
    return false if @membership.blank?
    
    if @membership.admin?
      setup_admin_permissions!
    else
      setup_default_permissions! #for guest

      setup_editor_permissions! if @membership.editor?

      setup_author_permissions!  if @membership.author?
    end
  end
  
  def setup_default_permissions!
    cannot :manage, :all
  end
  
  def setup_author_permissions!
    
    can :touch, Site do |site|
      site == @site
    end
    
    can :manage, [JournalArticle] do |article|
      article.site == @site and article.owner_id == @account.id
    end
    
    cannot [:edit, :update, :destroy], [JournalArticle] do |stated|
      stated.prepublished? or stated.published?
    end
    
    cannot :manage, JournalRubric
    can    :read, JournalRubric
  end
  
  def setup_editor_permissions
    #Editable contents
    can :manage, [Site, JournalRubric, JournalArticle] do |site|
      site == @site
    end
    
    cannot :create, Site
    
    #Memberships
    can :manage, Membership
    cannot :grant_admin, Membership
    cannot [:update, :destroy], Membership do |membership|
      @membership.account_id == membership.account_id || # can not edit myself
      membership.admin? # can not modify an administrator
    end
    
    
  end
  
  def setup_admin_permissions!
    can :manage, :all

    cannot [:update, :destroy], Membership do |membership|
      @membership.account_id == membership.account_id # can not edit myself
    end
  end
end