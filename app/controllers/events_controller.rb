class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    # using Model Method - upcoming - that queries database for the upcoming events.
    @events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])
    @likers = @event.likers
    # the event has many categories through categorizations
    @categories = @event.categories
    # If there's a current user, then try to get their like.
    if current_user
      # checking if current_user has already liked @event
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      # flash[:notice] = 'Event successfully updated!' => same as second part line 20
      # redirect_to @event = redict_to event_path(@event)
      redirect_to @event, notice: 'Event successfully updated!'
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
      redirect_to @event, notice: 'Event successfully created!'
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
    params.require(:event).permit(:name, :location, :price, :starts_at, :description, :capacity, :image_file_name, category_ids: [])
  end
end
