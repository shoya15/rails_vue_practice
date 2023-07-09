class User < ApplicationRecord
  has_secure_password
  
  has_many :tasks, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
end
