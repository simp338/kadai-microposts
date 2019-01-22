class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 50 }
  validates :email, presence: true, length: {maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :microposts
    #micropost.rbモデルと紐付け（manyなので-s）
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
    #following.rbモデルはないが、through: :relationshipsで
    #「relationshipsテーブルとこのテーブル（user)をinner join」することを示し、
    #source: :followで「follow_id
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :likes
  has_many :like_microposts, through: :likes, source: :micropost
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids+[self.id])
    #投稿のuser_idがフォローしている人のidと、自分のidであるものを抽出するメソッド => toppagesコントローラで使う
  end

  def like_m(micropost)
    self.likes.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unlike_m(micropost)
    like = self.likes.find_by(micropost_id: micropost.id)
    like.destroy if like
  end
  
  def like_now?(micropost)
    self.like_microposts.include?(micropost)
  end

end
