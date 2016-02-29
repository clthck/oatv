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
		params_list = params[:data].to_a
		json_data = {}
		begin
			case request.POST[:action]
			when 'create'
				attributes = params_list[0][1]
				category = MatchCategory.create! category_params(attributes)
			when 'edit'
				id = params_list[0][0]
				attributes = params_list[0][1]
				category = MatchCategory.find(id)
				category.update category_params(attributes)
			when 'remove'
				ids = params_list.collect { |e| e[0] }
				MatchCategory.where(id: ids).destroy_all
			end
			json_data = { data: [category] }
		rescue ActiveRecord::RecordNotUnique => e
			json_data = {
				error: "Ugh!",
				fieldErrors: [{
					name: 'name',
					status: 'Match category name has already been taken.'
				}]
			}
		end
		respond_to do |format|
			format.json { render json: json_data }
		end
	end

	private

	# Get strong parameters for CRUD
	def category_params(attributes)
		permissibles = [:name]
		if attributes.instance_of? Parameters
			attributes.permit(permissibles)
		else
			Parameters.new(attributes).permit(permissibles)
		end
	end
end
