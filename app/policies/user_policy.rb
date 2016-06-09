class UserPolicy < ApplicationPolicy
  def index?
    create?
  end
end
