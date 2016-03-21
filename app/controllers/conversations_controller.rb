class ConversationsController < ApplicationController
	include ActionController::Live

	# POST
	def create
		conversation = Conversation.between(params[:sender_id], params[:recipient_id])
		@conversation = conversation.present? ? conversation.first : Conversation.create!(conversation_params)
		respond_to :json
	end

	private

	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end
end
