module UsersHelper

  # Returns the gravatar for the given user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def is_admin?(user)
    user.current_role.downcase == "administrateur"
  end

  def is_dev?(user)
    user.current_role.downcase == "developpeur"
  end

  def is_super?(user)
    user.current_role.downcase == "superviseur"
  end



end
