class FavoritesController < ApplicationController
	def favorite

		# makes sure a user can't favorite a superlative multiple times by clicking quickly
		already_favorited = []
		current_user.favorite_superlatives.each do |title|
			if !(already_favorited.include?(title.id))
				already_favorited << title.id
			end
		end

		if already_favorited.include?(params[:user_id])
			redirect_to user_path(params[:user_id])
		else
			@favorite = current_user.favorites.new
			@favorite.title_id = params[:id]
			@favorite.save

			if @favorite.save
				redirect_to user_path(params[:user_id])
			else
				redirect_to root_path
			end
		end
	end

	def unfavorite
		@title = Title.find_by_id(params[:id])
		@favorites = Favorite.where(user_id: current_user.id).where(title_id: @title.id)
		@favorites.destroy_all

		if @favorites.destroy_all
			redirect_to user_path(params[:user_id])
		else
			redirect_to root_path
		end

	end

end
