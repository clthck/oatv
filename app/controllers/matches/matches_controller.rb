class Matches::MatchesController < ApplicationController
	# GET
	def index
		matches = current_user.club.matches.order(date: :desc)
		@match_categories = MatchCategory.all.order(:name).collect do |cat|
			{ value: cat.id, label: cat.name }
		end
		respond_to do |format|
			format.html
			format.json { render json: { data: 
				matches.as_json(include: :category)
				} }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = Match.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_user)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end
end
