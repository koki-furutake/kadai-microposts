class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favoritetables
  has_many :favorite_microposts, through: :favoritetables, source: :micropost

  #フォローメソッド
  def follow(other_user)
    unless self == other_user  #フォローしている人が自分自身でないかの検証
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  #アンフォローメソッド
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  #フォローしているかどうかのメソッド
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(other_micropost)
    self.favoritetables.find_or_create_by(micropost_id: other_micropost.id)
  end
  
  def unfavorite(other_micropost)
    micropost = self.favoritetables.find_by(micropost_id: other_micropost.id)
    micropost.destroy if micropost
  end
  
  def favorite?(other_micropost)
    self.favorite_microposts.include?(other_micropost)
  end
end