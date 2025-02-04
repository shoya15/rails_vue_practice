class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { maximum: 50 }, confirmation: true
  
  has_many :tasks, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "user_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :favorites, dependent: :destroy
  has_many :favorite_tasks, through: :favorites, source: :task
end
