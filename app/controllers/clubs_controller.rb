class ClubsController < ApplicationController
	# GET
	def choose_subscription_plan
	end

	# POST
	def activate_subscription_plan
		club = current_user.club
		club.active = true
		club.save
		flash[:notice] = "You have successfully activated your subscription plan!"
		redirect_to :back
	end

	# GET
	def players
		@players = current_user.club.players.joins(:profile).order('profiles.full_name asc')
		respond_to do |format|
			format.json
		end
	end
end
