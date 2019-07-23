class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }

  enum status: [:waiting, :doing, :done] 
end
