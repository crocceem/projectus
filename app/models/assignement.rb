# == Schema Information
#
# Table name: assignements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assignement < ActiveRecord::Base

  attr_accessor :id_user,:id_role,:id_project

  belongs_to :user, class_name:"User"
  belongs_to :role, class_name:"Role"
  belongs_to :project, class_name:"Project"

  validates :user_id, presence:true
  validates :role_id, presence:true
  validates :project_id, presence:true


end
