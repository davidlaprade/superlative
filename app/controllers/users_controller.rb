class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new]

	def new
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:user_id])
	end

	private
	def user_params
		params.require(:user).permit(:user_id)
	end
end
