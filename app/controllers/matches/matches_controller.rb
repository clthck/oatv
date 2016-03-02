class Matches::MatchesController < ApplicationController
	before_action :get_match_categories, only: [:index, :show]
	# GET
	def index
		matches = current_user.club.matches.order(date: :desc)
		respond_to do |format|
			format.html
			format.json { render json: { data: 
				matches.as_json(include: :category)
				} }
		end
	end

	# GET
	def show
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = Match.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_user)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end

	# GET
	def stats
	end

	private

	def get_match_categories
		@match_categories = MatchCategory.all.order(:name).collect do |cat|
			{ value: cat.id, label: cat.name }
		end
	end
end
