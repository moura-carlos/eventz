class Event < ApplicationRecord
  def self.upcoming
    # displaying only the upcoming events
    # select all events which date is later than Time.now and
    # orders it in ascending order (closest date - smaller - to farthest date - bigger)
    # Event is implicit in this case because of self so we don't need to put Event.where(query)
    where('starts_at > ?', Time.now).order('starts_at')
  end

  def free?
    # same as => self.price == 0
    price.blank? || price.zero? # checked wether price attribute is has not been set or is 0
  end
end
