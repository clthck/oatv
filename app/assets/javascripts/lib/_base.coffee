do (init = ($, window, document) ->

	$bodyEl = $('body')
	inputOldValue = undefined
	$sideNav = undefined

	# Define custom event 'changeBlur' for form input elements
	$bodyEl.on 'focus', 'input, textarea, select', ->
		inputOldValue = $(this).val()
	.on 'blur', 'input, textarea, select', ->
		$(this).trigger 'changeBlur' if inputOldValue isnt $(this).val()

	###
	Materialize blockUI
	###
	$.fn.extend
		materialBlock: (options) ->
			this.each ->
				$this = $(this).addClass('transition-all-short')
				$this.block $.extend({}, {
						message: 	"""
											<div class="preloader-wrapper active">
												<div class="spinner-layer">
													<div class="circle-clipper left"><div class="circle"></div></div>
													<div class="gap-patch"><div class="circle"></div></div>
													<div class="circle-clipper right"><div class="circle"></div></div>
												</div>
											</div>
											"""
						overlayCSS: { opacity: 0.1 }
						css: {
							border: 'none'
							backgroundColor: 'transparent'
						}
					},
					options)
				$this.addClass('blur-effect').find('.blockUI').insertAfter $this

		materialUnblock: ->
			this.each ->
				$this = $(this)
				$blockUiEl = $this.next '.blockUI'
				tmp = undefined
				while $blockUiEl.length > 0
					tmp = $blockUiEl
					$blockUiEl = $blockUiEl.next '.blockUI'
					tmp.prependTo $this
				$this.unblock().removeClass 'blur-effect'

	window.R.dtLoadingRecords = """
		<div class="preloader-wrapper active">
			<div class="spinner-layer spinner-blue">
				<div class="circle-clipper left"><div class="circle"></div></div>
				<div class="gap-patch"><div class="circle"></div></div>
				<div class="circle-clipper right"><div class="circle"></div></div>
			</div>
			<div class="spinner-layer spinner-red">
				<div class="circle-clipper left"><div class="circle"></div></div>
				<div class="gap-patch"><div class="circle"></div></div>
				<div class="circle-clipper right"><div class="circle"></div></div>
			</div>
			<div class="spinner-layer spinner-yellow">
				<div class="circle-clipper left"><div class="circle"></div></div>
				<div class="gap-patch"><div class="circle"></div></div>
				<div class="circle-clipper right"><div class="circle"></div></div>
			</div>
			<div class="spinner-layer spinner-green">
				<div class="circle-clipper left"><div class="circle"></div></div>
				<div class="gap-patch"><div class="circle"></div></div>
				<div class="circle-clipper right"><div class="circle"></div></div>
			</div>
		</div>
		"""

	###
	jQuery DOM document ready event handler
	###
	$ ->
		$('.nano').nanoScroller()
		$('.nano').each ->
			new ResizeSensor this, -> $(this).nanoScroller()
		new ResizeSensor document.getElementById('main-content'), -> $('body').nanoScroller()

		# For compatibility with turbolinks
		Waves.displayEffect()
		Materialize.updateTextFields()

		# Relocate .error-message for .file-field
		$('.file-field').each ->
			$this = $(this)
			$('input[type="file"] ~ .error-message', $this).appendTo $this

		# Open corresponding side nav menu with active child item
		$sideNav = $('#side-nav')
		$sideNav.find('li.active').parents('ul').parents('li').addClass('open')

		# Materialize dataTable Editor buttons
		$('.dt-buttons').addClass('btn-group')
		$('.dt-button').addClass('btn btn-rounded waves-effect waves-light')
		$('.dataTables_length').addClass('ml-20')

) ->
	init window.jQuery, window, document