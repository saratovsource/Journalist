class BaseController < ApplicationController
  include Journalist::Routing::SiteDispatcher
  include Journalist::Routing::BaseController

end
