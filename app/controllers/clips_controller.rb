class ClipsController < ApplicationController
	before_action :add_parent_breadcrumb, only: [:index]
	before_action :get_clip_categories, only: [:index]

	# GET
	def index
		current_club = current_user.club
		add_breadcrumb "Clips", match_video_clips_path
		clips = current_video.clips.order(:start)
		@playlists = current_club.playlists.order(:name)
		respond_to do |format|
			format.html
			format.json { render json: { data: clips.as_json(include: :category) } }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	# for video
	def datatables_editor_cud
		json_data = Clip.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_video)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end

	# GET
	def index_on_playlist
		add_breadcrumb "Playlists", playlists_path
		add_breadcrumb "Clips", playlist_clips_path
		@clips = current_playlist.clips.order(:id)
		respond_to do |format|
			format.html
			format.json
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	# for playlist
	def datatables_editor_cud_on_playlist
		json_data = Clip.datatables_editor_cud_on_playlist(request.POST[:action], params[:data].to_a, current_playlist)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end

	# POST
	def assign_clips_to_players
		clip_ids = params[:clip_ids].split(',')
		player_ids = params[:player_ids].split(',')
		Clip.assign_clips_to_players clip_ids, player_ids
		render json: {}
	end

	private

	# Add breadcrumbs for parent objects
	def add_parent_breadcrumb
		add_breadcrumb "Matches", current_match
		add_breadcrumb "Videos", match_videos_path
	end

	# Get clip categories
	def get_clip_categories
		@clip_categories = ClipCategory.all.order(:name).collect do |cat|
			{ value: cat.id, label: cat.name }
		end
	end
end
