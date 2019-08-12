class DashboardController < ApplicationController
 before_action :require_login, only:[ :index]
 private

 def require_login
  unless current_user  
   flash[:error] = "You must be logged in to access this section"
   redirect_to sessions_new_path
  end
 end
end
