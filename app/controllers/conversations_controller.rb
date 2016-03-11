class ConversationsController < ApplicationController
	include ActionController::Live

	# POST
	def create
		conversation = Conversation.between(params[:sender_id], params[:recipient_id])
		@conversation = conversation.present? ? conversation.first : Conversation.create!(conversation_params)
		respond_to :json
	end

	# GET
	def events
		response.headers["Content-Type"] = "text/event-stream"
		redis = Redis.new
		redis.psubscribe('conv/*') do |on|
			on.pmessage do |pchannel, channel, data|
				m = channel.match(/^conv\/(.+)$/)
				conversation = Conversation.find(m[1])
				if conversation.involved? current_user
					response.stream.write("data: #{data}\n\n")
				end
			end
		end
		response.stream.close
	end

	private

	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end
end
