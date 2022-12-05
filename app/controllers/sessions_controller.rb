class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    # checking if the 'user' is not nil and if the password passed in the form
    # matches the actual password of the given user.
    if user && user.authenticate(params[:password])
      # put user id in session
      session[:user_id] = user.id

      # redirect_to user, notice: "Welcome back, #{user.name}!"
      # redirect to the :intended_url and if there is not one redirect to the user's show page.
      # the redirect_to here just sets up the redirect.
      # So the line after it will still run.
      # And then when the action falls through, the redirect will actually happen.
      redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
      session[:intended_url] = nil
    else
      # In case of invalid email or password,
      # the flash message needs to be shown right away.
      # If we do "flash[:alert] = "Invalid email/password combination!",
      # the flash won't show up until the next request.
      # And rendering the new template - render :new - doesn't issue a new request.
      # The 'new' template is going to be rendered in the same request that ran the Create action.
      # That is why we need to use flash.now[:alert]
      # That will render the flash in the same request.
      flash.now[:alert] = 'Invalid email/password combination!'
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to events_url, status: :see_other, notice: "You're now signed out!"
  end
end
