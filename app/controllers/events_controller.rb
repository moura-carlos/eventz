class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    # using Model Method - upcoming - that queries database for the upcoming events.
    # The following code makes use of the following url path structure -> .../events?filter=free
    # Where 'free' is what changes ['past' 'free' 'recent'] based on which events we want to see.
    case params[:filter]
    when 'past'
      @events = Event.past
    when 'free'
      @events = Event.free
    when 'recent'
      @events = Event.recent
    else
      @events = Event.upcoming
    end

    # Another way is getting the following url structure -> events/filter/free
    # get "events/filter/:filter" => "events#index"
    # Where 'free' is what changes ['past' 'free' 'recent'] based on which events we want to see.
    # We can also make use of the code above, what changes is the url's look

  end

  def show
    # @event = Event.find(params[:id])
    # although we are finding by the 'slug' column, the url/route still uses 'id'
    # as the placeholder to store the value that identifies the event.
    # That is why we keep params[:id] and do not change to params[:slug]
    # @event = Event.find_by(slug: params[:id])
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
    # @event = Event.find(params[:id])
  end

  def update
    # @event = Event.find(params[:id])
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
    # @event = Event.find(params[:id])
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

  def set_event
    # finding an event by its slug value that is passed in the URL though the
    # :id key/placeholder
    @event = Event.find_by!(slug: params[:id])
  end
end
