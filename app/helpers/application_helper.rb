module ApplicationHelper
  # View helper method that returns the currently signed in user.
  # since we might use the 'current_user' helper method all over the application,
  # we're putting it in the global Application Helper (application_helper.rb).
  # def current_user
  #   # check that a user ID is in the session before calling find.
  #   # The line bellow will only run if there's a user ID in the session.
  #   User.find(session[:user_id]) if session[:user_id]
  # end
end
