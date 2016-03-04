class ClipCategoriesController < ApplicationController
	# GET
	def index
		add_breadcrumb "Clip Categories", :clip_categories_path
		categories = ClipCategory.all.order(:id)
		respond_to do |format|
			format.html
			format.json { render json: { data: categories } }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = ClipCategory.datatables_editor_cud(request.POST[:action], params[:data].to_a)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end
end
