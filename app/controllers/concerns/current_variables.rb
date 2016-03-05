module CurrentVariables
	extend ActiveSupport::Concern

	included do
		attr_reader :current_match, :current_video
		
		before_action :get_current_match
		before_action :get_current_video
	end

	protected

	# Get current match object
	def get_current_match
		@current_match ||= if params[:match_id]
			Match.find(params[:match_id])
		end
		@current_match
	end

	# Get current video objec
	def get_current_video
		@current_video ||= if params[:video_id]
			Video.find(params[:video_id])
		end
		@current_video
	end
end