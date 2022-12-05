class ApplicationController < ActionController::Base
  # Make all of these methods in this application controller private.
  # That way, they won't be shown like other controller actions.
  # To put it another way, you can't make a route that runs these methods.
  # They're intended to be called internally or privately
  # by the controller that inherits them.
  private
  # The code bellow makes the #current_user method available to all controllers
  def current_user
    # check that a user ID is in the session before calling find.
    # The line bellow will only run if there's a user ID in the session.
    User.find(session[:user_id]) if session[:user_id]
  end

  # in order to make the #current_user method
  # available to the views
  # we use the following code
  helper_method :current_user

  def require_signin
    unless current_user
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end
end
