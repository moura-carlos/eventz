class Event < ApplicationRecord
  before_save :set_slug
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

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
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

  scope :past, -> { where('starts_at < ?', Time.now).order('starts_at') }
  scope :upcoming, -> { where('starts_at > ?', Time.now).order('starts_at') }
  scope :free, -> { where('price = 0.0').order(:name) }
  # getting the most recent past 3 events, the ones that have just passed but are still recent.
  # scope :recent, -> { past.limit(3) }
  scope :recent, ->(max = 3) { past.limit(max) }
  # Creatomg scope that gets free and upcoming at the same time by using existing scope.
  # scope :free, -> { upcoming.where('price = 0.0').order(:name) }

  # to get events that are upcoming and free just run -> Event.upcoming.free (or Event.free.upcoming)

  # def self.upcoming
  #   # displaying only the upcoming events
  #   # select all events which date is later than Time.now and
  #   # orders it in ascending order (closest date - smaller - to farthest date - bigger)
  #   # Event is implicit in this case because of self so we don't need to put Event.where(query)
  #   where('starts_at > ?', Time.now).order('starts_at')
  # end

  # def self.past
  #   displaying only the past events
  #   select all events which date is before Time.now and
  #   orders it in ascending order (closest date - smaller - to farthest date - bigger)
  #   Event is implicit in this case because of self so we don't need to put Event.where(query)
  #   where('starts_at < ?', Time.now).order('starts_at')
  # end

  def free?
    # same as => self.price == 0
    price.blank? || price.zero? # checked wether price attribute is has not been set or is 0
  end

  def sold_out?
    # (self.capacity - self.registrations.size).zero?
    (capacity - registrations.size).zero?
  end

  # overriding the default behavior of the to_param method
  # which gets the id and uses it in the url shown to the user
  # instead, we want to show the name of the event in the url.
  # def to_param
  #   name.parameterize
  # end

  def to_param
    # returns the value of the slug attribute, which
    # is set by the set_slug method
    # before the object's info is saved to the database.
    slug
  end

  private
  def set_slug
    self.slug = name.parameterize
  end
end
