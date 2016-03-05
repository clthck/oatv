class Playlist < ActiveRecord::Base
  belongs_to :club

  has_many :playlist_clips
  has_many :clips, through: :playlist_clips
  
  has_many :playlist_questions

  # Handles create, update and remove action of DataTables Editor
	# and returns json hash
	def self.datatables_editor_cud(dte_action, data, club)
		json_data = {}
		begin
			case dte_action
			when 'create'
				attributes = data[0][1]
				attributes[:club_id] = club.id
				category = self.create! playlist_params(attributes)
			when 'edit'
				id = data[0][0]
				attributes = data[0][1]
				attributes[:club_id] = club.id
				category = self.find(id)
				category.update playlist_params(attributes)
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
					status: 'Playlist name has already been taken.'
				}]
			}
		rescue ActiveRecord::InvalidForeignKey => e
			json_data = {
				error: "One or more playlists are currently being referred by some clips!"
			}
		end
	end

	private

	# Get strong parameters for DataTables Editor CUD
	def self.playlist_params(attributes)
		permissibles = [:club_id, :name]
		if attributes.instance_of? ActionController::Parameters
			attributes.permit(permissibles)
		else
			ActionController::Parameters.new(attributes).permit(permissibles)
		end
	end
end
