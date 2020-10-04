class Request < ApplicationRecord
  belongs_to :user
  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..1000 }
  # validates :budget, numericality: { greater_tha_or_equal_to: 500, less_than_or_equal_to: 300000 }, allow_blank: true

  scope :sorted_desc, -> { order(created_at: :desc) }
end
