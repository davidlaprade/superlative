class FavoritesController < ApplicationController
	def favorite
		@favorite = Favorite.new
		@favorite.user_id = current_user.id
		@favorite.title_id = params[:id]

		@favorite.save

		if @favorite.save
			redirect_to user_path(params[:user_id])
		else
			redirect_to root_path
		end
	end

	def unfavorite
		@title = Title.find_by_id(params[:id])
		@favorites = Favorite.where(user_id: current_user.id).where(title_id: @title.id)
		@favorites.destroy_all

		if @favorite.destroy_all
			redirect_to user_path(params[:user_id])
		else
			redirect_to root_path
		end

	end

end
