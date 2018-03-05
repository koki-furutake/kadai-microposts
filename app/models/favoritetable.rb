class Favoritetable < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: 'Microposts'
  
  validates :user_id, presence: true
  validates :favorite_id, presence: true
end
