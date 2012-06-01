class ProfilesController < ::BaseController

  def show
    if current_account.blank?
      redirect_to "/page_not_found"
      return
    end
    @profile = current_account.profile
  end

  def edit
    show
  end

  def update
    edit
    @profile.update_attributes(params[:profile])
    redirect_to edit_profile_path
  end

  protected

  def set_default_sections
    @layout_sections = {
      :sidebar => {
        :name => "journalist/faces_navigation",
        :action => :widget,
        :options => {:current_site => current_site}
      }
    }
  end
end
