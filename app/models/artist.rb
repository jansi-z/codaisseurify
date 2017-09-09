class Artist < ApplicationRecord
  has_many :songs

  validates :name,  presence: true, length: { maximum: 50 }
  validates :image_url, presence: true

end
