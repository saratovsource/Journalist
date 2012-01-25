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
end