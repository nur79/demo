class SessionsController < ApplicationController
  def new
  	redirect_to root_path if signed_in?
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user and user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user
    else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
    end
  end

  def destroy
  	sign_out
		redirect_to root_path
  end
end
