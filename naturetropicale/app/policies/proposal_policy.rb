class ProposalPolicy < ApplicationPolicy

  def index?
    user.worker? 
  end

  def create?
    user.worker? 
  end

  def update?
    user.enterprise? or user.admin?
  end

  def destroy?
    user.enterprise?
  end
end
