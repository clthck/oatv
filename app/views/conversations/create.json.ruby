{
	id: @conversation.id,
	messages: @conversation.messages.recent(10)
}.to_json