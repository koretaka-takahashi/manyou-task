class User < ApplicationRecord
  before_destroy do
    throw(:abort) if User.where(admin: true).count <= 2 && self.admin?
  end

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, 
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  
  before_validation { email.downcase! }
  has_secure_password
end
