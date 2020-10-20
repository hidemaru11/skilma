class Plan < ApplicationRecord
  belongs_to :skill
  belongs_to :budget_unit

  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..1000 }
  validates :budget, numericality: { greater_tha_or_equal_to: 500, less_than_or_equal_to: 300000 }

  scope :sorted_desc, -> { order(created_at: :desc) }
end
