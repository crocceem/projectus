# == Schema Information
#
# Table name: roles_users
#
#  id         :integer          not null, primary key
#  role_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RolesUser < ActiveRecord::Base

  attr_accessor :id_role,:id_user

  belongs_to :user
  belongs_to :role
end
