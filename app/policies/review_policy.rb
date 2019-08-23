class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.reviews.find_by(plant_id: record.plant_id).nil?
  end
end
