class PostPolicy < ApplicationPolicy
  def delete?
    create?
  end
end
