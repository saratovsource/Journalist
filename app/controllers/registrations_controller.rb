class RegistrationsController < Devise::RegistrationsController
  include Journalist::Routing::SiteDispatcher

  layout "auth"

  before_filter :require_site
end
