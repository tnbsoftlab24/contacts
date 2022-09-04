class JobPolicy < ApplicationPolicy

  def create?
    user.enterprise? or user.admin?
  end

  def update?
    user.enterprise? or user.admin?
  end

  def destroy?
    user.enterprise?
  end

end
