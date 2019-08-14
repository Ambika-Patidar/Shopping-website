class HomeController < ApplicationController
  layout "login"
  before_action :require_login, only:[:index]
  
  def require_login
    if current_user 
      redirect_to dashboard_index_path
    else 
     redirect_to sessions_new_path
    end
  end

  def index
  end
end
