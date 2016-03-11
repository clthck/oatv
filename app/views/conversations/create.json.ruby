{
	id: @conversation.id,
	messages: @conversation.messages.order(created_at: :desc).limit(10)
}.to_json