class AssignementsController < ApplicationController
  def new
    @all_users = User.all
    @all_roles = Role.all
    @all_projects = Project.all
    @assignement = Assignement.new
  end

  def create
    @assignement = Assignement.new(assignement_params)
    if @assignement.save
      flash[:success] = "Assignement ok"
      redirect_to root_path
    else
      render'new'
    end
  end

  def index
    @user= current_user
  end

  def edit
    @assignement = Assignement.find(params[:id])
    @user = current_user
  end

  def update
    @assignement = Assignement.find(params[:id])
    @user = current_user
    current_active_assignement = Assignement.find_by(user_id:@user.id,active:true)
    if current_active_assignement.update_attributes(active:false) && @assignement.update_attributes(active:true)
      flash[:success] = "Affection modify"
      redirect_to user_assignement_path(@user.id,@assignement)
    else
      render 'edit'
    end

    def show

    end

  end

  private

  def assignement_params
    params.require(:assignement).permit(:user_id,:role_id,:project_id,:active)
  end

end