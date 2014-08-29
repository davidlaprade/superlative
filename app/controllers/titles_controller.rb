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
			redirect_to user_path(@user.id)
		else
			render 'new'
		end
	end

	def destroy
		@user = User.find_by_id(params[:user_id])
		@title = Title.find_by_id(params[:id])
		@title.delete

		if @title.delete
			redirect_to user_path(@user.id)
		else
			redirect_to users_path
		end
	end

	private
	def title_params
		params.require(:title).permit(:content)
	end

end
