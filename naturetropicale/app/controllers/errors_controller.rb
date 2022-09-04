class ErrorsController < ApplicationController

  #Add 404 error
  def not_found
    render(:status => 404)
  end
  
  #Add 500 error
  def internal_error
    render(:status => 500)
  end
  
end
