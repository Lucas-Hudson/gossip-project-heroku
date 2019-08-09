class SessionsController < ApplicationController

  def new
  end

  def create
    # Login
    # Looks if a user has that email in the db
    user = User.find_by(:email => params[:email])

    # checks if the user exists AND has entered the correct passward
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      puts user.id
      # redirige où tu veux, avec un flash ou pas
      redirect_to root_path

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # Login
    session.delete(:user_id)
    redirect_to root_path
  end

end
