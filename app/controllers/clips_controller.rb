class ClipsController < ApplicationController
	include CurrentVariables

	before_action :add_parent_breadcrumb
	before_action :get_clip_categories, only: [:index]

	# GET
	def index
		add_breadcrumb "Clips", match_video_clips_path
		clips = current_video.clips.order(:start)
		@playlists = current_user.club.playlists.order(:name)
		respond_to do |format|
			format.html
			format.json { render json: { data: clips.as_json(include: :category) } }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = Clip.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_video)
		respond_to do |format|
			format.json { render json: json_data }
		end
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
