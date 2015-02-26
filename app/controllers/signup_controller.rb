class SignupController < ApplicationController

  def new
  end

  def create
    user = User.new(
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
    )
    if user.save
      session[:current_user_id] = user.id
      flash[:notice] = 'You have successfully signed up'
    end
    redirect_to root_path
  end

end
