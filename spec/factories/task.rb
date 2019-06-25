# 「FactoryBotを使用します」という記述
FactoryBot.define do

  factory :task do
    name { 'test1' }
    content { 'test1をやる' }
  end

  factory :task2, class: Task do
    name { 'test2' }
    content { 'test2をやる' }
  end
end
