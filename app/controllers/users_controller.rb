class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new]

	def new
	end

	def index
		@users = User.all
	end
end
