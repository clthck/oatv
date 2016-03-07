# clips#for_me
R.pages['clips-for_me'] = do ($ = jQuery, window, document) ->
	run = ->
		$clipsItems = $('.collection-item', '#clips-list')
		monitorClip = undefined

		$clipsItems.on 'click', ->
			video = R.videojs_objs['video-clip']
			$this = $(this)
			video.src $this.data('clip-video-url')
			video.currentTime $this.data('clip-start')
			video.play()
			$clipsItems.removeClass 'active'
			$this.addClass 'active'
			video.off 'timeupdate', monitorClip if monitorClip?
			monitorClip = ->
				if video.currentTime() > $this.data('clip-end')
					video.pause()
					video.off 'timeupdate', monitorClip
			video.on 'timeupdate', monitorClip
		
	{ run: run }
