class DashboardController < ApplicationController
	skip_load_and_authorize_resource
	authorize_resource class: false
	
	# GET
	def index
	end

	# PUT
	def update_yaybar_hidden_state
		cookies.permanent[:yaybar_hidden] = params[:yaybar_hidden]
		render json: {}
	end
end
