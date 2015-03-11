class SignupController < PublicController

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
    )
    if @user.save
      session[:current_user_id] = @user.id
      flash[:notice] = 'You have successfully signed up'
      redirect_to new_project_path
    else
      render :new
    end
  end

end
