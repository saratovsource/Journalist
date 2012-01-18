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
  
end