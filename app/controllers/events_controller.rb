class EventsController < ApplicationController
  def index
    @events = %w[BugSmash Hackathon Campk].shuffle
  end
end
