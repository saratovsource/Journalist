class Godmode::CommentsController < Godmode::BaseController
  sections :publications

  def update
    params[:comment][:moderator_id] = current_account.id
    update!
  end

  protected

  def collection
    current_site.labels
  end

end
