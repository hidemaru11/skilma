class Job < ApplicationRecord
  belongs_to :user
  belongs_to :budget_unit

  acts_as_taggable_on :tags

  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..1000 }
  validates :area, length: { maximum: 255 }
  validates :budget, numericality: { greater_tha_or_equal_to: 500, less_than_or_equal_to: 300000 }, allow_blank: true

  scope :sorted_desc, -> { order(created_at: :desc) }

  def self.search(search)
    Job.where(['title LIKE ? OR content LIKE ? OR area LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  def self.my_posts(user_id)
    Job.where('user_id = ?', user_id)
  end
end
