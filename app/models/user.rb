class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, PhotoUploader

  has_many :plants
  has_many :bookings
  has_many :reviews
  has_many :booked_plants, through: :bookings, source: :plant
  validates :firstname, :lastname, :avatar, presence: true
end
