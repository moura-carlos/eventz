class RegistrationsController < ApplicationController
  before_action :require_signin #, only: [:new, :create]
  before_action :set_event, only: [:index, :new, :create, :destroy]

  def index
    # @event = Event.find(params[:event_id])
    @registrations = @event.registrations
  end

  def new
    # @event = Event.find(params[:event_id])
    @registration = @event.registrations.new
    # @registration = @event.registrations.new
  end

  def create
    # the reason we need to instantiate the @event and
    # @registration objects again is because @instance
    # variables don't live on after an action runs.
    # in this case the previously ran action was 'new'
    # @event = Event.find(params[:event_id])
    @registration = @event.registrations.new(registration_params)
    @registration.user = current_user
    if @registration.save
      # removes one spot out of capacity from the event, since a new person has registered
      @event.capacity = @event.capacity - 1
      @event.save
      redirect_to event_registrations_url(@event), notice: 'Thanks for registering!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  # /events/:event_id/registrations/:id(.:format)	registrations#destroy
    # @event.registrations.find(params[:id])
    @registration = Registration.find(params[:id])
    @user = @registration.user# User.find(@event.registrations.find(params[:id]).user)
    if current_user?(@user)
      # @event.registrations.find_by!(params[:user])
      @registration.destroy
      redirect_to @user, notice: "Your registration was successfully cancelled!"
    else
      redirect_to @event, notice: "You cannot cancel this registration!"
    end

  end

  private
  def registration_params
    # params.require(:registration).permit(:name, :email, :how_heard)
    params.require(:registration).permit(:how_heard)
  end

  # This method makes the @event instance variable available to the actions index, new, and create.
  # before any of the actions in the list are run, this method is run.
  def set_event
    # @event = Event.find(params[:event_id])
    @event = Event.find_by!(slug: params[:event_id])
  end
end
