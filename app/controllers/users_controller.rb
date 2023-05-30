class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #check if the user exists
    @user = User.find_by({"email" => params["user"]["email"]})
    #case true (=1) - (if exists, it won't return empty)
    if @user
      flash["notice"] = "This email already exists"
      redirect_to "/users/new"
    #case false (=0) - (if it does not exist, it will return empty)
    else
      @user = User.new
      @user["first_name"] = params["user"]["first_name"]
      @user["last_name"] = params["user"]["last_name"]
      @user["email"] = params["user"]["email"]
      @user["password"] = BCrypt::Password.create(params["user"]["password"])
      @user.save
    redirect_to "/posts"
    end
  end
end
