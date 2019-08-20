class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :plant
  validates :start_date, :end_date, :status, presence: true
end
