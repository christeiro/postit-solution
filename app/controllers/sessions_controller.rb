class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(username: params[:username]).authenticate(params[:password])

		if user
			flash[:notice] = "You've logged in!"
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:error] = "Your username or password are incorrect! Please try again!"
			render 'new'
		end
	end

	def destroy
		session.clear
		flash[:notice] = "You've been logged out!"
		redirect_to root_path
	end

	private
	def post_params
		params.permit(:username, :password)
	end
end