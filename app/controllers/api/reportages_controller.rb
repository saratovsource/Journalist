class Api::ReportagesController < Api::ApplicationController
  defaults :resource_class => ::Reportage

  def show
    @items = resource.images
  end
end
