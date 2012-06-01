class RegistrationsController < Devise::RegistrationsController
  include Journalist::Routing::SiteDispatcher

  layout "auth"

  before_filter :require_site

  def create
    super
    current_site.memberships.create(:role => "guest", :account => resource)
    current_site.profiles.create(:owner => resource)
  end
end
