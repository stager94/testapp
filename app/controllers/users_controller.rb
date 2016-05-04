class UsersController < ApplicationController

	before_action :find_user
	respond_to :json

  def update
  	@user.update permitted_params
  	render json: @user
  end

private
	
	def find_user
		@user = User.find(params[:id])		
	end

	def permitted_params
		params.require(:user).permit(:name)
	end

end
