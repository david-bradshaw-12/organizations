class UsersController < ApplicationController
  def new
  end

  def create
  	p params
  	@user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to all_groups_path
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to :back
    end
  end
  private
	  def user_params
	      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	  end
end
