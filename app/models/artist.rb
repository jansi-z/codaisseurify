class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy

  mount_uploader :image_url, ImageUploader

  validates :name,  presence: true, length: { maximum: 50 }
  # validates :image_url, presence: true

end
