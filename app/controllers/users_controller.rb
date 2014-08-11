class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new, :index]

	def new
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:id])
	end

end
