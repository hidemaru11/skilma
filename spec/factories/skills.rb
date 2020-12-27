FactoryBot.define do
  factory :skill do
    title { "ピアノ弾けます" }
    content { "ピアノ歴30年間で、作編曲を行なってきました。" }
    tag_list { "piano" }
    association :user
  end
end
