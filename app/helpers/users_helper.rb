module UsersHelper

  # Returns the gravatar for the given user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def role_user(user)
    user.assignements.each do |assignement|
      if assignement.active
        return assignement.role.role
      end
    end
  end

  def project_user(user)
    user.assignements.each do |assignement|
      if assignement.active
        return assignement.project.name
      end
    end
  end


end
