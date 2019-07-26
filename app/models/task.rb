class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }

  enum status: [:waiting, :doing, :done] 

  scope :sort_by_deadline, -> {order(deadline: "ASC")}
  scope :normal_sort, -> {order(created_at: "DESC")}
  scope :search_by_name, -> params {where("name LIKE ?", "%#{ params[:task][:name]}%")}
  scope :search_by_status, -> params {where(status: params[:task][:status])}
end
