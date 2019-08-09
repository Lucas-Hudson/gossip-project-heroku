class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    u = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])

    #Checks if the city exists, if it doesn't, creates a new city and gives it's ID to the new user.
    a = City.find_by(:name => params[:city])

    if a.blank? == true
      City.create(:name => params[:city])
      a2 = City.find_by(:name => params[:city]).id
      u.city_id = a2
    else
      a = City.find_by(:name => params[:city]).id
      u.city_id = a
    end
    u.save

    # Redirect to root_path with stored session id
     session[:user_id] = u.id
     redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
