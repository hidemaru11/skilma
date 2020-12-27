FactoryBot.define do
  factory :mate do
    title { "R&Bが好きです" }
    content { "R&Bの曲をもっと知りたいのでいい曲があったら教えてください" }
    area { "神奈川" }
    tag_list { "R&B" }
    association :user
  end
end
