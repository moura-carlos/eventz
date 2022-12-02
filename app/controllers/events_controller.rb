class EventsController < ApplicationController
  def index
    # using Model Method - upcoming - that queries database for the upcoming events.
    @events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      # redirect_to @event = redict_to event_path(@event)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @event = Event.new
  end

  def create
    # @event = Event.create(event_params) => creates new event and saves to database.
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_url, status: :see_other
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :price, :starts_at, :description)
  end
end
