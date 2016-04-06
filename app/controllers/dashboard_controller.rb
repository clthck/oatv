class DashboardController < ApplicationController
	skip_load_and_authorize_resource
	authorize_resource class: false
	
	# GET
	def index
	end

	def index_for_coach
		@activities = PublicActivity::Activity.where(key: 'clip.watch').limit(6)
	end

	def index_for_player
	end

	# PUT
	def update_yaybar_hidden_state
		cookies.permanent[:yaybar_hidden] = params[:yaybar_hidden]
		render json: {}
	end
end
