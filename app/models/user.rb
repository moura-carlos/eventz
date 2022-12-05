class User < ApplicationRecord
  # When a user is deleted, we want all of that user's registrations to also be deleted.
  has_many :registrations, dependent: :destroy

  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
end
