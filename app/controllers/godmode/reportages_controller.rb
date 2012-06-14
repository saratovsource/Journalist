class Godmode::ReportagesController < Godmode::BaseController
  custom_actions :collection => [:empty, :prepublished, :published, :tags]
  sections :publications

  def empty
    @reportage = current_site.reportages.create(
      :owner_id => current_account.id,
      :title => I18n.t('reportage.default_title'),
      :slug => Journalist::UniqGenerator.generate(:prefix => "reportage"),
      :parent_id => current_site.id)
    redirect_to edit_godmode_reportage_path(@reportage)
  end

  def update
    update! do |format|
      @reportage.send(params[:after_action]) unless params[:after_action].blank? #Try send action
      if @reportage.errors.empty?
        format.html { redirect_to is_redactor? ? prepublished_godmode_reportages_path : collection_url(:state => @reportage.state) }
      end
    end
  end

  def tags
   @tags = resource_class.tags_with_weight
  end

  protected

  def collection
    where_params = { :site_id => current_site.id }

    #Sort By State
    unless params[:state].blank?
      states = states_from_params(params[:state])
    else
      states = Reportage.state_machines[:state].states.keys
    end
    states = states.compact

    if is_redactor?
      @collection ||= current_site.reportages.with_states([:prepublished, :published])
    else
      @collection ||= end_of_association_chain.where(where_params).with_states(states.compact)
    end
    @collection.page(params[:page]).per(params[:per_page])
  end

  def resource
    if is_redactor?
      @resource = current_site.reportages.find(params[:id])
    else
      super
    end
  end

  def begin_of_association_chain
    current_account
  end

  def states_from_params(state)
    states = []
    if %w(drafted rewrited).include?(state)
      states << :drafted << :rewrited
    else
      states << state
    end
    states
  end

end
