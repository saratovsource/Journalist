class PasswordsController < Devise::PasswordsController
  include Journalist::Routing::SiteDispatcher
  
  layout "auth"
  
  before_filter :require_site
  
end