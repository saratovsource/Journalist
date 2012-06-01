class Godmode::LabelsController < Godmode::BaseController
  sections :publications

  def create
    @label = current_site.labels.build(params[:label].merge(:site => current_site))
    create! do |success, failure|
      success.html{ redirect_to godmode_labels_path }
      failure.html{ redirect_to godmode_labels_path }
    end
  end

  def update
    update!{ godmode_labels_url }
  end

  protected

  def collection
    current_site.labels
  end
end
