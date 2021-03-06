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

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name:"Example User", email:"user@example.com",cip:"croe1801",
                     password:"foobar", password_confirmation:"foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present "do
    @user.name ="  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "cip should me present" do
    @user.cip = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a"*244 +"@example.com"
    assert_not @user.valid?
  end

  test "cip should not be too long" do
    @user.cip = "a"*9
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email= valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "cip validation should accept valid cips" do
    valid_cips = %w[croe1801 admin1801 rube1500 allo0001]
    valid_cips.each do |valid_cip|
      @user.cip = valid_cip
      assert @user.valid?, "#{valid_cip.inspect} should be valid"
    end
  end

  test "cip validation should reject invalid cips" do
    invalid_cips = %w[1801cipa 14ci85ps eca1458 alloha1480]
    invalid_cips.each do |invalid_cip|
      @user.cip = invalid_cip
      assert_not @user.valid?, "#{invalid_cip.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "cip should be unique" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.email ="croe@outlook.fr"
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end

end

