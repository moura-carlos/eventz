module EventsHelper
  # The methods created in this helper are accessible to any Event-related views.
  # View helper to display the price of an event.
  def price(event)
    # #free? is defined in the Event Model, bc whether an event is free or not is a business descision.
    if event.free?
      'Free'
    else
      number_to_currency(event.price, precision: 0)
    end
  end

  # View helper to display the day and time of an event.
  def day_and_time(event)
    if event.starts_at.nil? == false
      event.starts_at.strftime("%B %d at %I:%M %P")
    end
  end
end
