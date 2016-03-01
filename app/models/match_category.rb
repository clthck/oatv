class MatchCategory < ActiveRecord::Base
	has_many :matches

	# Handles create, update and remove action of DataTables Editor
	# and returns json hash
	def self.datatables_editor_cud(dte_action, data)
		json_data = {}
		begin
			case dte_action
			when 'create'
				attributes = data[0][1]
				category = self.create! category_params(attributes)
			when 'edit'
				id = data[0][0]
				attributes = data[0][1]
				category = self.find(id)
				category.update category_params(attributes)
			when 'remove'
				ids = data.collect { |e| e[0] }
				self.where(id: ids).destroy_all
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
		rescue ActiveRecord::InvalidForeignKey => e
			json_data = {
				error: "One or more categories are currently being referred by some matches!"
			}
		end
	end

	private

	# Get strong parameters for DataTables Editor CUD
	def self.category_params(attributes)
		permissibles = [:name]
		if attributes.instance_of? ActionController::Parameters
			attributes.permit(permissibles)
		else
			ActionController::Parameters.new(attributes).permit(permissibles)
		end
	end
end
