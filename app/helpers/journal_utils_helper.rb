module JournalUtilsHelper

  def name_of_user(user)
    user.profile.name || user.name
  end

end
