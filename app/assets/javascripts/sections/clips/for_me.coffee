# clips#for_me
R.pages['clips-for_me'] = do ($ = jQuery, window, document) ->
	run = ->
		$clipsItems = $('.collection-item', '#clips-list')
		monitorClip = undefined

		$clipsItems.on 'click', ->
			video = R.videojs_objs['video-clip']
			$this = $(this)
			srcPrev = video.src()
			video.src $this.data('clip-video-url')
			video.currentTime $this.data('clip-start')
			video.play()
			if $this.data('clip-video-url') isnt srcPrev
				video.one 'loadedmetadata', ->
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

		$('#clips-list-wrapper').height $('#video-clip-wrapper').height()

		new ResizeSensor document.getElementById('video-clip-wrapper'), ->
			$('#clips-list-wrapper').height $('#video-clip-wrapper').height()

		$statsPopup = $('#stats-popup')
		$statsPopupContent = $('.modal-content', $statsPopup)

		$('#view-stats').on 'click', ->
			$activeItemEl = $('.active', '#clips-list')
			unless $activeItemEl.length > 0
				Materialize.toast 'Select clip first!', 4000, 'rounded'
				return
			$statsPopup.openModal()
			$statsPopupContent.materialBlock()
			$.ajax
				type: 'get'
				url: Routes.stats_match_path($activeItemEl.data('match-id'))
				success: (data) -> $statsPopupContent.html(data).materialUnblock()
		
	{ run: run }
