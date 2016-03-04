module CurrentVariables
	extend ActiveSupport::Concern

	included do
		attr_reader :current_match
		before_action :get_current_match
	end

	protected

	def get_current_match
		@current_match ||= if params[:match_id]
			Match.find(params[:match_id])
		end
		@current_match
	end
end