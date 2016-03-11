# Core library to handle real time chat feature

do (init = ($, window, document) ->

	$ ->
		$messageListNanoEl = $('.messages .list .nano')
		$messageListNanoContentEl = $('.messages .list .nano-content')
		$messageSendForm = $('.messages .send form')
		$messageBodyEl = $('#message-body')
		current_conversation_id = undefined
		current_user_id = undefined
		$currentUserImgEl = []
		lastMessageDate = new Date(0)

		# Returns message html for a given message object
		messageHtml = (message) ->
			return '' if message.conversation_id isnt current_conversation_id
			timeDiff = (moment(message.created_at) - moment(lastMessageDate)) / 1000
			dateHtml = if timeDiff > 60
				"""<div class="date">#{moment(message.created_at).format('llll')}</div>"""
			else
				""
			lastMessageDate = message.created_at
			if message.user_id is current_user_id
				"""
					#{dateHtml}
					<div class="from-me">#{message.body}</div>
					<div class="clear"></div>
				"""
			else
				"""
					#{dateHtml}
					<div class="from-them">#{$currentUserImgEl[0].outerHTML}#{message.body}</div>
					<div class="clear"></div>
				"""

		# Start conversation by clicking one of the contacts
		$('.user', '.contacts').on 'click', ->
			$this = $(this)
			current_user_id = $this.data('sender-id')
			$currentUserImgEl = $('.photo', $this)
			$.ajax
				url: Routes.conversations_path()
				type: 'post'
				data:
					sender_id: $this.data('sender-id')
					recipient_id: $this.data('recipient-id')
				dataType: 'json'
				success: (data) ->
					current_conversation_id = data.id
					$messageSendForm.attr 'action', Routes.conversation_messages_path(data.id)
					# Code for populating messages goes here.
					htmls = []
					htmls.push messageHtml(message) for message in data.messages
					$messageListNanoContentEl.html htmls.join('')
					$messageListNanoEl.nanoScroller().nanoScroller scroll: 'bottom'

		# To cancel con's submit hook behavior and validate message before sending
		$messageSendForm.off('submit').on 'submit', -> $messageBodyEl.val().trim().length > 0

		# Subscribe to redis channel for real time chat function
		eventSource = new EventSource(Routes.events_conversations_path())
		eventSource.addEventListener 'message', (e) ->
			data = JSON.parse e.data
			if data.conversation_id is current_conversation_id
				$newMsg = $(messageHtml(data))
				$messageListNanoContentEl.append $newMsg
				$messageListNanoEl.nanoScroller().nanoScroller scroll: 'bottom'
				if data.user_id is current_user_id
					$messageBodyEl.val('')
					$newMsg.animateCSS 'zoomInRight', duration: 500
				else
					$newMsg.animateCSS 'zoomInLeft', duration: 500
			else
				# Code for showing unread messages for inactive rooms goes here...

) ->
	init window.jQuery, window, document
