class Review < ApplicationRecord
  belongs_to :plant
  belongs_to :user

  RATINGS = (1..5)

  validates :rating, presence: true, numericality: { only_integer: true }
  validates :rating, inclusion: { in: RATINGS }

  def self.average_rating
    return 0 if all.size.zero?

    (all.map(&:rating).sum / all.size).ceil
  end
end
