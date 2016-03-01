class Matches::MatchCategoriesController < ApplicationController
	# GET
	def index
		categories = MatchCategory.all.order(:id)
		respond_to do |format|
			format.html
			format.json { render json: { data: categories } }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = MatchCategory.datatables_editor_cud(request.POST[:action], params[:data].to_a)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end
end
