# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  cip             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  remember_digest :string
#  current_role    :string
#

class User < ActiveRecord::Base

  has_many :roles_users
  has_many :roles, :through => :roles_users
  has_many :assignements, class_name: "Assignement",
                                 foreign_key: "user_id",
                                 dependent: :destroy

  has_many :rolesusers, through: :active_assignements, source: :role

  attr_accessor :remember_token

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_CIP_REGEX = /\A[a-z]{4,5}[0-9]{4}\z/i

  validates :name, presence:true, length: {maximum:50}
  validates :email, presence: true, length: {maximum:255}, format:{with: VALID_EMAIL_REGEX}, uniqueness:{case_sensitive:false}
  validates :cip, presence: true, length: {maximum:8}, format:{with: VALID_CIP_REGEX}, uniqueness:true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil:true

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string,cost:cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_digest)
    return flase if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest,nil)
  end

  # Assigne un role à un user
  def assigne_job(role,project)
    assigmenents.create(role_id: role,project_id: project)
  end

  # Delete assignement for a user
  def unassigne_job(role,project)
    assignements.create(role_id:role,project_id:project).destroy
  end



end
