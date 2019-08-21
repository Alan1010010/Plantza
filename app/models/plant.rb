class Plant < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  has_many :bookings
  has_many :users, through: :bookings
  validates :name, :price, :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
