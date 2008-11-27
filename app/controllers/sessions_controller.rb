class SessionsController < ApplicationController
  def new
    session[:requested_uri] = request.env["HTTP_REFERER"] unless session[:requested_uri]
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.first_name}!"
      if back = session[:requested_uri]
        redirect_to back and return
      else
        redirect_to posts_url
      end
    else
      flash[:error] = "Invalid user login combionation!"
      render :action => :new
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = "You've been logged out."
    redirect_to new_session_url
  end
end
