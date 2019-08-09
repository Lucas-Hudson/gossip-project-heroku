class UsersController < ApplicationController
  def index
  end

  def show
    puts "user show" * 10
    @user = User.find(params[:id])
  end

  def new
    puts "user new" * 10
    #@user = User.new
  end

  def create
    puts "user create" * 10
    u = User.new
    u.email = params[:email]
    u.first_name = params[:first_name]
    u.password = params[:password]
    u.city_id = City.all.sample.id
    u.save

  # Redirect to root_path with stored session id
   session[:user_id] = u.id
   redirect_to root_path


    # a = City.find_by(:name => params[:city])
    # puts "@" * 100
    # puts a.blank?
    # puts "@" * 100

    # if a.blank? == true
    #   puts "@" * 100
    #   puts "C'est BLANK"
    #   puts "@" * 100
    #   City.create(:name => params[:city])
    #   a2 = City.find_by(:name => params[:city]).id
    #   u.city_id = a2
    # else
    #   puts "@" * 100
    #   puts "C'est PAS BLANK"
    #   puts "@" * 100
    #   a = City.find_by(:name => params[:city]).id
    #   puts "#" * 100
    #   puts a
    #   puts "#" * 100
    #   u.city_id = a
    #   u.save
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
