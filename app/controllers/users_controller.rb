class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit,:update]

  def new
    @user = User.new
    @all_roles = Role.all
    @all_projects = Project.all

  end

  def show
    @user = User.find(params[:id])
     @user.assignements.each do |assignement|
       if assignement.active
         @assignement = assignement
       end
     end
  end

  def create

    @user = User.new(user_params)
    if @user.save
      @user.assignements.create(role_id:@user.current_role,
                                project_id:@user.current_project,
                                active:true)

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

  def assignement
    @user=User.find(params[:id])
    @assignements = @user.assignements
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:cip,:password,:password_confirmation,:current_role,:current_project)
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
