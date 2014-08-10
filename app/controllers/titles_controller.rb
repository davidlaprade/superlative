class TitlesController < ApplicationController

	def new
		@user = User.find_by_id(params[:user_id])
		@title = @user.titles.new
	end

	private
	def title_params
		params.require(:title).permit(:content)
	end

end
