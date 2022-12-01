class Event < ApplicationRecord
  def free?
    # same as => self.price == 0
    price.blank? || price.zero? # checked wether price attribute is has not been set or is 0
  end
end
