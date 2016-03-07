window.R ||= {}

do ($ = jQuery, window, document) ->
	$ ->
		R.videojs_objs ||= {}

		$(document)
			.on 'page:before-change', ->
				video.dispose() for id, video of R.videojs_objs
				R.videojs_objs = {}
			.on 'ready page:load', ->
				$('.video-js').each -> R.videojs_objs[this.id] = videojs(this.id, $(this).data('setup-deferred'))
