class UsersController < ApplicationController
	# before_action :require_user, except: [:new, :show]
	before_action :set_user, only: [:show, :edit, :update]
	before_action :require_same_user, only: [:edit, :update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(post_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = 'Your account was created!'
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		if !@user
			flash[:error] = "You're not allowed to do that"
			redirect_to root_path
		end
	end

	def update
		if @user.update(post_params)
			flash[:notice] = "Your profile was updated"
			redirect_to user_path
		else
			render 'edit'
		end
	end

	def show
	end

	private
	def post_params
		params.require(:user).permit(:username, :password, :timezone)
	end

	def set_user
		@user = User.find_by(slug: params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:error] = "Your not allowed to do that!"
			redirect_to root_path
		end
	end

end