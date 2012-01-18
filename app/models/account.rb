require 'digest'

class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  
  devise *Journalist.config.devise_modules
  
  # -= Attributes =-
  field :name
  field :locale, :default => Journalist.config.default_locale.to_s or 'en'
  field :switch_site_token
  
  # -= Validations =-
  validates_presence_of :name
  
  # -= Callbacks =-
  before_destroy :remove_memberships!
  
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