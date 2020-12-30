FactoryBot.define do
  factory :job do
    title { "ギターを演奏して欲しいです" }
    content { "新曲のレコーディングでギターを入れたいので、演奏できる人を探してます。" }
    area { "埼玉" }
    budget { 10000 }
    tag_list { "ギター" }
    association :user
    association :budget_unit
  end
end
