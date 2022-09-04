
class Admin::UserPolicy < ApplicationPolicy
  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end
  def index?
    user.comptable?  || record.user == user
     @current_user.assistant? || @current_user.admin?
  end
end