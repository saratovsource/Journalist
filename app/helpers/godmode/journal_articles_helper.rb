module Godmode::JournalArticlesHelper
  def box_active_state?(state, current_state)
    current_state = "drafted" if current_state == "rewrited"
    return (state == current_state)
  end
  
end