class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  # Upon successful login:
  # redirects to admin dashboard if user is admin
  # redirects to customer dashboard if user is a customer
  def after_sign_in_path_for(resource)
    return admin_dashboard_path if current_user.admin?
    return customer_dashboard_path if current_user.customer?
  end

  def require_admin 
    redirect_to root_path unless current_user.admin?
  end
  
end
