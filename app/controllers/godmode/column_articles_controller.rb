class Godmode::ColumnArticlesController < Godmode::BaseController

  sections :publications

  def empty
    @column_article = ColumnArticle.create_new( :site => current_site, :owner => current_account, :parent => current_account.column )
    redirect_to edit_godmode_column_article_path(@column_article)
  end

  def update
    update! do |format|
      @column_article.send(params[:after_action]) unless params[:after_action].blank? #Try send action
      if @column_article.errors.empty?
        format.html { redirect_to is_redactor? ? resource_url : collection_url(:state => @column_article.state) }
      end
    end
  end

  protected

  def collection
    where_params = { :site_id => current_site.id }

    #Sort By State
    unless params[:state].blank?
      states = states_from_params(params[:state])
    else
      states = ColumnArticle.state_machines[:state].states.keys
    end
    states = states.compact

    @collection ||= end_of_association_chain.where(where_params).with_states(states.compact)
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
