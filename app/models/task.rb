class Task < ApplicationRecord
end

validates :name, presence: true, length: {maximum: 30}
validates :content, presence: true, length: {maximum: 1000}
