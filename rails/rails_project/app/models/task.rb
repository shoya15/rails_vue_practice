class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 100 }

  belongs_to :user
  
  has_many :favorites, dependent: :destroy
end
