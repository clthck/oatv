class Clip < ActiveRecord::Base
  belongs_to :video
  belongs_to :category, class_name: 'ClipCategory'

  has_many :clip_players
  has_many :players, through: :clip_players

  has_many :playlist_clips
  has_many :playlists, through: :playlist_clips

  has_many :clip_questions

  # Handles create, update and remove action of DataTables Editor
	# and returns json hash
	def self.datatables_editor_cud(dte_action, data, video)
		json_data = {}
		begin
			case dte_action
			when 'create'
				attributes = data[0][1]
				clip = self.new clip_params(attributes)
				clip.video = video
				clip.save!
			when 'edit'
				id = data[0][0]
				attributes = data[0][1]
				attributes[:start] = Moment.to_seconds(attributes[:start])
				attributes[:end] = Moment.to_seconds(attributes[:end])
				clip = self.find(id)
				clip.update clip_params(attributes)
			when 'remove'
				ids = data.collect { |e| e[0] }
				self.where(id: ids).destroy_all
			end
			json_data = { data: [clip.as_json(include: :category)] }
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
	def self.clip_params(attributes)
		permissibles = [:category_id, :name, :start, :end]
		if attributes.instance_of? ActionController::Parameters
			attributes.permit(permissibles)
		else
			ActionController::Parameters.new(attributes).permit(permissibles)
		end
	end
end
