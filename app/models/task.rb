class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, inverse_of: :tasks
  accepts_nested_attributes_for :task_labels, allow_destroy: true

  validates :name, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }

  enum status: [:waiting, :doing, :done] 
  enum priority: [:high, :middle, :low] 

  scope :sort_by_deadline, -> {order(deadline: "ASC")}
  scope :sort_by_priority, -> {order(priority: "ASC")}
  scope :sort_by_created_at, -> {order(created_at: "DESC")}
  scope :search_by_name, -> params {where("name LIKE ?", "%#{ params[:task][:search_task_name]}%")}
  scope :search_by_status, -> params {where(status: params[:task][:search_task_status])}
  # scope :search_by_label, -> params {where(id: TaskLabel.where(label_id: params[:task][:search_task_label]).pluck(:task_id))}
end
