module Godmode::BaseHelper
  
  def title(title = nil)
    if title.nil?
      @content_for_title
    else
      @content_for_title = title
      ''
    end
  end
  
  def box_button_tag(label)
    content_tag(:button, content_tag(:span, label), :type => 'submit', :class => 'button')
  end
  
  def next_installation_step_link(step = 1, label = nil)
    link_to(content_tag(:span, label || t('godmode.installation.common.next')), godmode_installation_step_url(step), :class => 'button')
  end
  
  def drop_down_menu_item(name = nil, icon = "", url = '#', args = {})
    content_tag :li do
      content_tag(:a, content_tag(:span, name, :class => "icon #{icon}"), args.merge(:href => url))
    end
  end
  
  def drop_down_menu_divider(attributes={ :class => "divider" })
    content_tag(:li, nil,  attributes)
  end
  
  def render_sidebar_menu
    render :partial => "sidebar_menu" if @sidebar_menu
  end
  
  def link_to_destroy(url= nil, name = :destroy)
    link_to I18n.t(name), url, :method => :delete, :confirm => t(:are_you_shure), :class => "btn danger pull-left"
  end
  
  def render_fieldsets(template_name, form)
    render :partial => "godmode/shared/fieldsets/#{template_name}", :locals => { :f => form }
  end
  
  def account_type
    session[:account_type]
  end
  
  def show_selector?
    current_account.role_in?(%w(editor admin))
  end
  
  def render_editor_selector
    render :partial => "godmode/shared/editor_switcher" if show_selector?
  end
  
  def filter_params(filter_target)
    case filter_target
    when Account
      params.merge(:rubric => nil, :author => filter_target)
    when JournalRubric
      params.merge(:author => nil, :rubric => filter_target)
    else
      {}
    end
  end
  
  def fieldset_tag(legend = nil, options = nil, &block)
    content = capture(&block)
    output = tag(:fieldset, options, true)
    output.safe_concat(content_tag(:legend, t("godmode.fieldsets.#{legend}"))) unless legend.blank?
    output.concat(content)
    output.safe_concat("</fieldset>")
  end
  
  def partners_accounts
    current_site.godmode_accounts.reject{|acc| acc.id == current_account.id}.collect{|acc| [acc.name, acc.id]}
  end
  
  def random_scale_image
    image_tag "journalist/auth/auth#{1.upto(3).sort_by{ rand }.slice(1)}.jpg", :class => "scaleimg"
  end
end