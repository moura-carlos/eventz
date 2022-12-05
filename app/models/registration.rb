class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :user
  # We no longer have the attributes bellow in the registrations table,
  # so we can remove these validations
  # validates :name, presence: true

  # validates :email, format: { with: /\S+@\S+/ }

  HOW_HEARD_OPTIONS = [
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
