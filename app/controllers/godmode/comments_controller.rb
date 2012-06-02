class Godmode::CommentsController < Godmode::BaseController
  sections :feedback

  def update
    params[:comment][:moderator_id] = current_account.id
    update!
  end

  protected

  def collection
    with_params_state(current_site.comments)
  end

  def with_params_state(items)
    params_state = params[:state]
    items = items.revert
    if params_state.present?
      items.with_state(params_state)
    else
      items
    end
  end

end
