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

require 'test_helper'

class RolesUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
