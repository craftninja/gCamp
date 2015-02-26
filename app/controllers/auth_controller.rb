class AuthController < ApplicationController

  def destroy
    session.destroy
    flash[:notice] = 'You have successfully signed out'
    redirect_to root_path
  end

  def new
  end

  def create
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:notice] = 'You have successfully signed in'
      redirect_to root_path
    end
  end

end
