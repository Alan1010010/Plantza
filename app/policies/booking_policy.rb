class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def destroy?
    return true
    record.user == user
  end
end
