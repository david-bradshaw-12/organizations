class SessionsController < ApplicationController
	def new
		render 'login'
	end
  def create
    errors = []
  	@user = User.find_by(email: params[:email])
  	if @user
  		if @user.authenticate(params[:password])
  			session[:user_id] = @user.id
  			return redirect_to all_groups_path
  		else
  			errors << 'invalid password'
  		end
  	else
  		errors << 'No account with that email.'
  	end
  	redirect_to :back, alert: errors
  end
  def destroy
  	if session.key? 'user_id'
  		session.clear
  		redirect_to :root
  	end
  end
end
