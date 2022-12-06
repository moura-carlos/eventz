class Event < ApplicationRecord
  # when an Event is destroyed, all its associated registrations are also destroyed.
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  # We could know the users who like an event by using "event.users",
  # which is a command provided by the code "has_many :users, through: :likes"
  # however, that is not very descriptive.
  # In order to change that to say "event.likers" we can change
  # that line of code to the following one in order to tell Rails
  # that when we say "likers" we really mean "users"
  # has_many :users, through: :likes
  has_many :likers, through: :likes, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  validates :name, :location, presence: true
  validates :description, length: { minimum: 25 } # this will check for both presence and size at same time
  # validates that price is a number (int, float...) and is >= 0
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality:
                      { only_integer: true,
                        greater_than: 0 }
  # validates the image file name and extension using regular expression
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
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

  def sold_out?
    # (self.capacity - self.registrations.size).zero?
    (capacity - registrations.size).zero?
  end
end
