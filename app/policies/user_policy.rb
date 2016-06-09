class UserPolicy < ApplicationPolicy
  def index?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def delete?
    create?
  end

end
