class VideosController < ApplicationController
	include CurrentVariables
	respond_to :html

	before_action :add_parent_breadcrumb

	# GET
	def index
	end

	# GET
	def new
		add_breadcrumb "Add New", new_match_video_path
	end

	# POST
	def create
		@video = Video.new video_params
		@video.match = current_match
		if @video.save
			flash[:notice] = "Video has been successfully added!"
			redirect_to match_videos_path
		else
			flash[:alert] = "Could not add video."
			respond_with @video
		end
	end

	private

	def add_parent_breadcrumb
		add_breadcrumb "Match", self.current_match
		add_breadcrumb "Videos", match_videos_path
	end

	def video_params
		params.require(:video).permit(:url)
	end
end
