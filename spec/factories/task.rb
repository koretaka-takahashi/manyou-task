FactoryBot.define do
  factory :task do
    name { 'test1' }
    content { 'test1をやる' }
    updated_at { Time.current + 1.days }
    deadline { Time.current + 2.days }
    status { 0 }
    priority { 0 }
    user_id { 1 }
    user
  end  
    
  factory :task2, class: Task do
    name { 'test2' }
    content { 'test2をやる' }
    updated_at { Time.current + 2.days }
    deadline { Time.current + 1.days }
    status { 1 }
    priority { 2 }
    user_id { 2 }
    user
  end
  
  factory :task3, class: Task do
    name { 'test3' }
    content { 'test3をやる' }
    user_id { 3 }
    user
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

