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

	# GET
	def for_me
		@clips = current_user.becomes(Player).clips.order('clip_players.created_at desc')
	end

	def log_player_activity_on
    Clip.find(params[:id]).create_activity action: :watch, owner: current_user
    render json: {}
	end

	def search
		@matches = current_user.club.matches.order(date: :desc)
		@clip_categories = ClipCategory.all

		clip_category_id = params[:clip_category_id]
		if clip_category_id.present?
			@clips = Clip.where(category_id: clip_category_id)
		end

		if params[:match_id].present?
			video_ids = current_match.videos.pluck(:id)
		else
			video_ids = []
			@matches.each { |match| video_ids += match.videos.pluck(:id) }
		end

		@clips = @clips.where(video_id: video_ids)
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
