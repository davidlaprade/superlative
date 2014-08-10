class TitlesController < ApplicationController

	def new
		@title = User.find_by_id(params[:user_id]).titles.new
	end

	private
	def title_params
		params.require(:title).permit(:content)
	end

end
