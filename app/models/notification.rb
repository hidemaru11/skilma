class Notification < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :message, optional: true
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  scope :sorted_desc, -> { order(created_at: :desc) }
end
