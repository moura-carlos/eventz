class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    # Before this action even runs the :require_correct_user method is run, thus setting @user
    # The code bellow is already set by the before_action :require_correct_user
    # so we can comment the code bellow
    # @user = User.find(params[:id])
  end

  def update
    # Before this action even runs the :require_correct_user method is run, thus setting @user
    # The code bellow is already set by the before_action :require_correct_user
    # so we can comment the code bellow
    # @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Before this action even runs the :require_correct_user method is run, thus setting @user
    # The code bellow is already set by the before_action :require_correct_user
    # so we can comment the code bellow
    # @user = User.find(params[:id])
    if @user.destroy
      session[:user_id] = nil
      redirect_to events_url, status: :see_other, alert: 'Account successfully deleted!'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    # checking if currently signed in user is the same as the user
    # the current user is trying to edit, update or delete.
    redirect_to events_url unless current_user?(@user)
  end
end
