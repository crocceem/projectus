# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base

  has_many :roles_users
  has_many :users, :through => :roles_users

  validates :role, presence:true

end
