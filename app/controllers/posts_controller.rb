class PostsController < ApplicationController

    def index
      @posts = Post.all
    end
  
    def new
      if @current_user
        @post = Post.new
      else
        flash["notice"] = "You must login to post"
        redirect_to "/login"
      end
    end
  
    def create
      #case true (=1) - let the user create the post
      if @current_user
        @post = Post.new
        @post["body"] = params["post"]["body"]
        @post["image"] = params["post"]["image"]
        @post["user_id"] = @current_user["id"]
        @post.save
        redirect_to "/posts"       
      #case false, show a message
      else
        flash["notice"] = "You must login to post"
        redirect_to "/login"  
      end
    end
  
  end