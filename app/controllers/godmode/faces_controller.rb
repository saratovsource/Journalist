class Godmode::FacesController < Godmode::BaseController

  def create
    @face = current_site.faces.build(:owner => current_user)
    create!
  end
end
