class BudgetUnit < ApplicationRecord
  has_many :jobs
  has_many :plans
end
