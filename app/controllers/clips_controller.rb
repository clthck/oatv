class ClipsController < ApplicationController
	include CurrentVariables
	
	before_action :add_parent_breadcrumb

	# GET
	def index
		add_breadcrumb "Clips", match_video_clips_path
	end

	private

	def add_parent_breadcrumb
		add_breadcrumb "Matches", current_match
		add_breadcrumb "Videos", match_videos_path
	end
end
