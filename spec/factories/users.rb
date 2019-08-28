FactoryBot.define do
  factory :user do
    name { "a" }
    email { "a@a.com" }
    password { "aaaaaa" }
    password_confirmation { "aaaaaa" }
  end

  factory :user2, class: User do
    name { "b" }
    email { "b@b.com" }
    password { "bbbbbb" }
    password_confirmation { "bbbbbb" }
  end

  factory :user3, class: User do
    name { "c" }
    email { "c@c.com" }
    password { "cccccc" }
    password_confirmation { "cccccc" }
  end
end
