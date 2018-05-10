class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authentication_required 
  	if !logged_in?
  		redirect_to login_path
  	end 
  end 

  def logged_in?
  	!!current_user 
  end 

  def current_user 
  	@current_user ||=  User.find(session[:user_id]) if session[:user_id]
  end 


  def can_current_user?(action, object)
    object.send("#{action}able_by?", current_user)   #=> Dynamic Dispatch (Metaprogramming)

    # case action 
    # when :view  
    #   object.viewable_by?(current_user)
    # when :edit 
    #   object.editable_by?(current_user)
    # end 
  end 


end
