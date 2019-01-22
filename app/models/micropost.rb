class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
            #:reverses_of_like, class_name: "like", foreign_key: "user_id"
  has_many :like_users, through: :likes, source: :user
  
  validates :content, presence: true, length: { maximum: 255 }
end
