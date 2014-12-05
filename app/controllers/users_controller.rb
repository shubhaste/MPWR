class UsersController < ActionController::Base
	def index
 		@users = User.all
	end

	def show
		
	end	
end
