FactoryBot.define do
  factory :task do
    name { 'test1' }
    content { 'test1をやる' }
    id { 1 }
    updated_at { Time.current + 1.days }
    deadline { Time.current + 2.days }
    status { 0 }
    priority { 0 }
  end  
    
  factory :task2, class: Task do
    name { 'test2' }
    content { 'test2をやる' }
    id { 2 }
    updated_at { Time.current + 2.days }
    deadline { Time.current + 1.days }
    status { 1 }
    priority { 2 }
  end
  
    # factory :task3, class: Task do
    #   name { 'test3' }
    #   content { 'test3をやる' }
    # end
  
    # factory :task4, class: Task do
    #   name { 'test4' }
    #   content { 'test4をやる' }
    # end
  
    # factory :task5, class: Task do
    #   name { 'test5' }
    #   content { 'test5をやる' }
    # end
end

