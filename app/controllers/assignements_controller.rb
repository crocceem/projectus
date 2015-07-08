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

  private

  def assignement_params
    params.require(:assignement).permit(:user_id,:role_id,:project_id)
  end

end