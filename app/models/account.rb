require 'digest'

class Account
  include Journalist::Document

  devise *Journalist.config.devise_modules
  # -= Devise =-
  ## Database authenticatable
  #field :email,              :type => String, :null => false
  #field :encrypted_password, :type => String, :null => false

  ## Recoverable
  #field :reset_password_token,   :type => String
  #field :reset_password_sent_at, :type => Time

  ### Rememberable
  #field :remember_created_at, :type => Time

  ### Trackable
  #field :sign_in_count,      :type => Integer
  #field :current_sign_in_at, :type => Time
  #field :last_sign_in_at,    :type => Time
  #field :current_sign_in_ip, :type => String
  #field :last_sign_in_ip,    :type => String

  ### Encryptable
  #field :password_salt, :type => String

  ## -= Attributes =-
  #field :name
  #field :locale, :default => Journalist.config.default_locale.to_s or 'en'
  #field :switch_site_token

  # -= CarrierWave =-
  mount_uploader :avatar, AvatarUploader

  # -= Associations =-
  has_many :journal_rubrics,    :class_name => "JournalRubric",   :foreign_key => "owner_id"
  has_many :journal_articles,   :class_name => "JournalArticle",  :foreign_key => "owner_id", :order => "updated_at DESC"
  has_many :media_collections,  :class_name => "MediaCollection", :foreign_key => "owner_id"
  has_many :comments,           :class_name => "Comment",         :foreign_key => "owner_id"
  has_one  :column,             :class_name => "Column",          :foreign_key => "owner_id"
  has_many :faces,   :class_name => "Face",  :foreign_key => "owner_id", :order => "updated_at DESC"

  # -= Validations =-
  validates_presence_of :name

  # -= Callbacks =-
  before_destroy  :remove_memberships!

  # -= Methods =-

  def sites
    @sites ||= Site.where({ 'memberships.account_id' => self._id })
  end

  def reset_switch_site_token!
    self.switch_site_token = ActiveSupport::SecureRandom.base64(8).gsub("/", "_").gsub(/=+$/, "")
    self.save
  end

  def self.find_using_switch_site_token(token, age = 1.minute)
    return if token.blank?
    self.where(:switch_site_token => token, :updated_at.gt => age.ago.utc).first
  end

  def self.find_using_switch_site_token!(token, age = 1.minute)
    self.find_using_switch_site_token(token, age) || raise(Mongoid::Errors::DocumentNotFound.new(self, token))
  end

  def role_in?(roles)
    self.sites.each do |site|
      membership = site.memberships.where(:account_id => self._id).first
      return roles.include?(membership.role)
    end
  end

  def membership(site)
    site.memberships.where(:account_id => self.id).first
  end

  protected

  def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end

  def remove_memberships!
    self.sites.each do |site|
      membership = site.memberships.where(:account_id => self._id).first

      if site.admin_memberships.size == 1 && membership.admin?
        raise I18n.t('errors.messages.needs_admin_account')
      else
        membership.destroy
      end
    end
  end
end
