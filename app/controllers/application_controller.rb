class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	@commits = Commit.includes(:user).ordered.by_user_email(params[:user_email]).paginate(page: params[:page], per_page: 30)
  end

  def pull
  	GitHub::Importer.new(username: params[:username], repository_name: params[:repository]).execute
  	redirect_to root_path
  end
end
