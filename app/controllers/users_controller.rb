class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit,:update]

  def new
    @user = User.new
    @all_roles = Role.all
    @roles_user = @user.roles_users.build
  end

  def show
    @user = User.find(params[:id])

  end

  def create

    @user = User.new(user_params)

    params[:roles][:id].each do |role|
      if !role.empty?
        @user.roles_users.build(:role_id => role)
      end
    end
    if @user.save
      flash[:success] = "Welcome to ProjectUS"
      redirect_to @user
    else
      render'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @all_roles = @user.roles.all
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:cip,:password,:password_confirmation,:current_role)
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
