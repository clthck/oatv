class VideosController < ApplicationController
	respond_to :html

	before_action :add_parent_breadcrumb

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
						session[:analysis_data_file_info] = {
							file_name: filename,
							content_type: @uploaded_file.content_type
						}
					end
					flash[:notice] = "Video has been successfully added!"
				else
					flash[:alert] = "Could not add video.\\n#{@video.errors.full_messages.join("\\n")}"
				end
			rescue Yt::Errors::RequestError => e
				flash[:alert] = "Youtube video does not seem to be valid."
			end
			format.js
		end
	end

	# GET, Content-Type: text/event-stream
	def analyze_data
		file_info = session[:analysis_data_file_info]
		if file_info
			response.headers['Content-Type'] = 'text/event-stream'
			analyzer = ClipDataAnalysis.new @video, file_info['file_name']['path'], file_info['content_type']
			analyzer.analyze do |percent|
				response.stream.write "id: IN_PROGRESS\n\n"
				response.stream.write "data: #{percent.round}\n\n"
			end
			session.delete :analysis_data_file_info
			response.stream.write "id: FINISHED\n\ndata: \n\n"
			response.stream.close
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
