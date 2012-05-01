class Godmode::FacesController < Godmode::BaseController

  def new
    #@face = current_site.faces.build(:owner => current_account)
    @face = Face.new(:owner => current_account, :site => current_site )
  end

  def create
    new
    create!
  end
end
