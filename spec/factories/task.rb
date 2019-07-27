FactoryBot.define do

  factory :task do
    name { 'test1' }
    content { 'test1をやる' }
  end

  factory :task2, class: Task do
    name { 'test2' }
    content { 'test2をやる' }
  end

  factory :task3, class: Task do
    name { 'test3' }
    content { 'test3をやる' }
  end

  factory :task4, class: Task do
    name { 'test4' }
    content { 'test4をやる' }
  end

  factory :task5, class: Task do
    name { 'test5' }
    content { 'test5をやる' }
  end
end
