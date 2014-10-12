class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new, :index]

	def new
	end

	def index
		@users = User.all
		if !(user_signed_in? && current_user.role == "guest")
    		User.where(role: "guest").each do |guest|
      			guest.favorite_superlatives.delete_all
      			Title.where(created_by: guest.id).delete_all
		    end
		end
	end

	def show
		@user = User.find_by_id(params[:id])
	end


end
