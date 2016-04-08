class VideosController < ApplicationController
	respond_to :html

	before_action :add_parent_breadcrumb

	include ActionController::Live

	# GET
	def index
		@videos = current_match.videos.order(created_at: :asc)
	end

	# GET
	def new
		add_breadcrumb "Add New", new_match_video_path
	end

	# POST
	def create
		@video = Video.new video_params
		@video.match = current_match

		respond_to do |format|
			begin
				if @video.save
					@uploaded_file = params[:analysis_data]
					unless @uploaded_file.nil?
						filename = Rails.root.join 'tmp', 'upload', 'analysis_data'
						File.open filename, 'wb' do |file|
							file.write @uploaded_file.read
						end
						analyzer = ClipDataAnalysis.new(@video, filename, @uploaded_file.content_type)
						analyzer.analyze
					end
					flash[:notice] = "Video has been successfully added!"
				else
					flash[:alert] = "Could not add video.\\n#{@video.errors.full_messages.join("\\n")}"
				end
			rescue Yt::Errors::RequestError => e
				flash[:alert] = "Youtube video does not seem to be valid."
			end
			respond_with @video, location: match_videos_path
		end
	end

	# DELETE
	def destroy
		@video.destroy
		flash[:notice] = "Video has been deleted."
		redirect_to match_videos_path
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
