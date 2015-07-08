# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  has_many :roles, :through => :assignements
  has_many :users, :through => :assignements
  has_many :assignements
end
