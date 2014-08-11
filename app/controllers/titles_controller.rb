class TitlesController < ApplicationController

	def new
		@user = User.find_by_id(params[:user_id])
		@title = @user.titles.new
	end

	def create
		@user = User.find_by_id(params[:user_id])
		@title = @user.titles.create(title_params)
		@title.created_by = current_user.id

		if @title.save
			redirect_to root_path
		else
			render 'new'
		end
	end


	private
	def title_params
		params.require(:title).permit(:content)
	end

end
