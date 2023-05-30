class SessionsController < ApplicationController
  def new
  end
  
  def create
    # authenticate the user
      #find user by email
      @user = User.find_by({"email" => params["email"]})
      #case true (user is found =1) - (if exists, it won't return empty)
      if @user
        #Check is password matches --> if matches, store the user's id in a secure cookie and redirect to "/posts" with a fash message
        if BCrypt::Password.new(@user["password"]) == params["password"]
           session["user_id"] = @user["id"]
           flash["notice"] = "Welcome, #{@user["first_name"]}!"
           redirect_to "/posts" 
        #if authentication fails: redirect to /login with a flash message
        else
           flash["notice"] = "Your password is not correct"
           redirect_to "/login"
        end  
      #case no user is found:  
      else
        flash["notice"] = "No user found"
        redirect_to "/login"  
      end  
        
  end

  #code to logout an user:
  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end

end



