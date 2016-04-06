module CurrentVariables
	extend ActiveSupport::Concern

	included do
		attr_reader :current_match, :current_video, :current_playlist
		
		before_action :get_current_match
		before_action :get_current_video
		before_action :get_current_playlist
	end

	protected

	# Get current match object
	def get_current_match
		@current_match ||= if params[:match_id].present?
			Match.find(params[:match_id])
		end
	end

	# Get current video objec
	def get_current_video
		@current_video ||= if params[:video_id].present?
			Video.find(params[:video_id])
		end
	end

	# Get current playlist objec
	def get_current_playlist
		@current_playlist ||= if params[:playlist_id].present?
			Playlist.find(params[:playlist_id])
		end
	end
end