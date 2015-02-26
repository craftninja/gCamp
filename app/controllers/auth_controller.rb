class AuthController < ApplicationController

  def destroy
    session.destroy
    flash[:notice] = 'You have successfully signed out'
    redirect_to root_path
  end

end
