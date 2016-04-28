class Match < ActiveRecord::Base
  belongs_to :club
  belongs_to :category, class_name: 'MatchCategory'

  has_many :videos, dependent: :destroy
  has_one :match_stat
  accepts_nested_attributes_for :match_stat

  # Handles create, update and remove action of DataTables Editor
	# and returns json hash
	def self.datatables_editor_cud(dte_action, data, user)
		json_data = {}
		begin
			case dte_action
			when 'create'
				attributes = data[0][1]
				match = self.new match_params(attributes)
				match.club = user.club
				match.save!
			when 'edit'
				id = data[0][0]
				attributes = data[0][1]
				match = self.find(id)
				match.update match_params(attributes)
			when 'remove'
				ids = data.collect { |e| e[0] }
				self.where(id: ids).destroy_all
			end
			json_data = { data: [match.as_json(include: :category)] }
		rescue StandardError => e
			json_data = {
				error: "Ugh!",
				fieldErrors: [{
					name: 'name',
					status: e
				}]
			}
		end
	end

	private

	# Get strong parameters for DataTables Editor CUD
	def self.match_params(attributes)
		permissibles = [:name, :category_id, :date]
		if attributes.instance_of? ActionController::Parameters
			attributes.permit(permissibles)
		else
			ActionController::Parameters.new(attributes).permit(permissibles)
		end
	end
end
