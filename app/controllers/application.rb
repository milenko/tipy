# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7e00532d9f02ab509301b1846411913d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
  def check_authentication
    unless session[:user]
      session[:requested_uri] = request.env["REQUEST_URI"]
      redirect_to sign_in_url
    else
      @user = User.find(session[:user])
    end
  end
  
end
