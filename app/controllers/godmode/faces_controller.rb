class Godmode::FacesController < Godmode::BaseController
  sections :publications

  def empty
    @face = current_site.faces.create(:owner => current_account)
    redirect_to edit_godmode_face_path(@face)
  end

  protected

  def collection
    where_params = { :site_id => current_site.id }

    #Sort By State
    unless params[:state].blank?
      states = states_from_params(params[:state])
    else
      states = Face.state_machines[:state].states.keys
    end
    states = states.compact

    @collection ||= end_of_association_chain.where(where_params).with_states(states.compact)
  end

end
