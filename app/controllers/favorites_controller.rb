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
	end

end
