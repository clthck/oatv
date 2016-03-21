class MessagesController < ApplicationController

	# POST
	def create
		conversation = Conversation.find(params[:conversation_id])
		@message = conversation.messages.build(message_params)
		@message.user = current_user
		@message.save!
		respond_to :js
	end

	private

	def message_params
		params.require(:message).permit(:body)
	end
end
