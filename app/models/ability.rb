class Ability
  include CanCan::Ability

  ROLES = %w(admin editor author guest)

  def initialize(account = nil, site)
    @account, @site = account, site

    return false if @account.nil?
    alias_action :index, :show, :edit, :update, :to => :touch

    if @account.present?

      @membership = @site.memberships.where(:account_id => @account.id).first

      return false if @membership.blank?

      if @membership.admin?
        setup_admin_permissions!
      else
        setup_default_permissions! #for guest

        setup_author_permissions!  if @membership.author?

        setup_editor_permissions! if @membership.editor?
      end
      any_columns_presissions!
    else
      setup_default_permissions!
    end

  end

  def setup_default_permissions!
    cannot :manage, :all

    cannot :manage, [Account]

    can :manage, [MediaCollection, MediaFile] do |mb|
      mb.owner_id == @account.id or mb.owner_id.nil?
    end
    can [:index, :read, :show], [MediaCollection, MediaFile]
    can [:change_user, :read], [Account]
  end

  def setup_author_permissions!

    can :touch, Site do |site|
      site == @site
    end

    can :manage, [JournalArticle, ColumnArticle] do |article|
      article.site == @site and article.owner_id == @account.id
    end

    cannot [:edit, :update, :destroy], [JournalArticle] do |stated|
      stated.prepublished? or stated.published?
    end

    cannot [:edit, :update, :destroy], [ColumnArticle] do |stated|
      stated.published?
    end

    cannot :manage, JournalRubric
    can    [:read, :show, :articles], [JournalRubric, Account]
  end

  def setup_editor_permissions!
    setup_author_permissions!

    #Editable contents
    can :manage, [JournalRubric, JournalArticle, ColumnArticle, Account, ColumnArticle] do |sitable|
      sitable.site == @site
    end

    cannot :create, Site

    #Memberships
    cannot :grant_admin, Membership
    cannot [:update, :destroy], Membership do |membership|
      @membership.account_id == membership.account_id || # can not edit myself
      membership.admin? # can not modify an administrator
    end

    cannot [:edit, :destroy], [JournalArticle] do |stated|
      stated.prepublished? or stated.published?
    end

    can [:show, :read], [JournalArticle, ColumnArticle] do |stated|
      stated.prepublished? or stated.published?
    end

    can [:read, :show, :articles ], Account

  end

  def setup_admin_permissions!
    can :manage, :all

    #cannot [:update, :destroy], Membership do |membership|
    #  @membership.account_id == membership.account_id # can not edit myself
    #end
  end

  protected

  def any_columns_presissions!
  end
end
