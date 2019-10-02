FactoryBot.define do
  factory :label do
    name { "A" }
  end

  factory :label2, class: Label do
    name { "B" }
  end

  factory :label3, class: Label do
    name { "C" }
  end
end
