class PasswordsController < Devise::PasswordsController
  include Journalist::Routing::SiteDispatcher
  
  before_filter :require_site
end