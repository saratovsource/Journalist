class Godmode::PagesController < Godmode::BaseController
  sections :publications

  def create
    @page = current_site.pages.build(params[:page].merge(:owner => current_account))
    create! do |success, failure|
      success.html{ redirect_to godmode_pages_path }
      failure.html{ render :new }
    end
  end

  def update
    update!{ godmode_pages_path }
  end

  protected

  def collection
    current_site.pages.page(params[:page]).per(params[:per_page])
  end
end
