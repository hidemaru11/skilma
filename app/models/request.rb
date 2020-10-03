class Request < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 3..100 }
  validates :content, presence: true, length: { in: 3..1000 }
end
