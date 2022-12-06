class User < ApplicationRecord
  # When a user is deleted, we want all of that user's registrations to also be deleted.
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  # We could know which events were liked by a given user by using "user.events",
  # which is a command provided by the code "has_many :events, through: :likes"
  # however, that is not very descriptive.
  # In order to change that to say "user.liked_events" we can change
  # that line of code to the following one in order to tell Rails
  # that when we say "liked_events" we really mean "events"
  # has_many :events, through: :likes
  has_many :liked_events, through: :likes, source: :event

  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
end
