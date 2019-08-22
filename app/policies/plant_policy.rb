class PlantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.geocoded
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
