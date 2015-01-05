class UsersController < ApplicationController
  before_filter :authenticate_user!,:admin_only

  #before_filter :admin_only, :except => :show

  def index
    @users = User.all
    #.where.not(id: [4,5])
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    if current_user.has_role? :admin or  current_user.has_role? :super_admin
      true
    else
     redirect_to home_index_path, :alert => "Access denied."
    end
  end


  def secure_params
    #permit(:user, roles_attributes:[ :] )
    #params.require(:user).permit(:roles)
    params.require(:user).permit(:is_active,:role_ids => [])
  end

end
