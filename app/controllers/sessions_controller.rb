class SessionsController < ApplicationController
	before_action 

	def new 
		@user = User.new 
	end 

	def create 
		if auth
			@user = User.find_or_create_by_omniauth(auth)
			session[:user_id] = @user.id 
			
			redirect_to root_path
		else 

			@user = User.find_by(email: params[:email])
			if @user && @user.authenticate(params[:password])
				session[:user_id] = @user.id 
				redirect_to root_path
			else 
				render :new 
			end 
		end 
	end 

	def destroy
		reset_session
		redirect_to login_path
	end 

	private 

	def auth
		request.env['omniauth.auth']
	end 


end
