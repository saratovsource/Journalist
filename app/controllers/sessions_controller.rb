class SessionsController < Devise::SessionsController
  include Journalist::Routing::SiteDispatcher
  
  #layout '/admin/layouts/box'
  
  before_filter :require_site
end