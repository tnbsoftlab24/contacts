class Admin::DashboardPolicy < Struct.new( :admin)
  def index
    user.admin? 
  end

  # def create?
  #   user.enterprise? 
  # end

  # def update?
  #   user.enterprise? or user.admin?
  # end

  # def destroy?
  #   user.enterprise?
  # end

end
