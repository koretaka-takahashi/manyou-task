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
end
